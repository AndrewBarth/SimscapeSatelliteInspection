import os
import numpy as np
import copy
import gymnasium as gym
from gymnasium import spaces
from gymnasium.spaces import Discrete, Box, Tuple, Dict
from ray.rllib.env.multi_agent_env import MultiAgentEnv
from ray.rllib.utils.typing import MultiAgentDict

from cpp_wrapper import cppWrapper
from task_trajectory import taskTraj
from randomize_scenario import randomState
from utils import reward_utils
from utils import orbit_utils
from utils import hill2eci
from utils import OEToCartesian


class CubesatTaskEnv(MultiAgentEnv):


    def __init__(self,  *args, **kwargs):

        super().__init__()

        self.nAgents = kwargs['nAgents']
        self.agent_ids = {1} 
        self._agent_ids = {1}  # Later version of Ray require a private variable
        for i in range(2,self.nAgents+1):
            self.agent_ids.add(i)
            self._agent_ids.add(i)

        self.earth_radius = 6378.0   # km
        self.earth_mu = 398600 # km^3/s^2
        # Process arguments
        self.scenario_type = kwargs['scenario_type']
        self.init_type = kwargs['init_type']

        # Define the parameter bounds. Used for normalizing observations and
        # selecting values in random case 
        self.ref_altitude_bounds = kwargs['altitude_bounds']
        self.task_semimajor_bounds = kwargs['semimajor_bounds']
        self.task_eccentricity_bounds = kwargs['eccentricity_bounds']
        self.task_inc_bounds = kwargs['inclination_bounds']
        self.task_period_bounds = kwargs['task_period_bounds']
        self.task_type = kwargs['task_type']
        self.chief_bounds = kwargs['chief_bounds']
            
        self.min_period = orbit_utils.compute_period(self.ref_altitude_bounds[0]+self.earth_radius)
        self.max_period = orbit_utils.compute_period(self.ref_altitude_bounds[1]+self.earth_radius)

        self.nInspectionFaces = 32

        if self.init_type == 'random':

            # Instantiate class to define the random state
            self.random_state = randomState()
            
        else:
            self.chief_state = np.array(kwargs['chief_state'])
            # All agents assumed to be on the same orbit as target
            self.ref_altitude = {}
            for agent_id in self.agent_ids:
                self.ref_altitude[agent_id] = kwargs['altitude']

        # Define the parameters used in the reward equations
        self.reward_parameters = {}
        self.reward_parameters['success'] = {}
        self.reward_parameters['success']['threshold'] = 1.0
        self.reward_parameters['success']['reward_value'] = 10.0

        self.reward_parameters['coverage'] = {}
        self.reward_parameters['coverage']['scale_factor'] = 1.0
        self.reward_parameters['coverage']['exponent'] = 1.8
        self.reward_parameters['coverage']['bias'] = -1.0

        self.reward_parameters['time'] = {}
        self.reward_parameters['time']['scale_factor'] = -5.0 
        self.reward_parameters['time']['power'] = 1.0 
        self.reward_parameters['time']['bias'] = 0.0 

        self.terminateds = set()
        self.truncateds = set()

        self._spaces_in_preferred_format = True

        # Define the action space
        self._action_space_in_preferred_format = True
        box_act_space = {}
        for agent_id in self.agent_ids:
            box_act_space[agent_id] = Box(low=np.array([self.task_semimajor_bounds[agent_id][0], \
                                                        self.task_eccentricity_bounds[agent_id][0], \
                                                        self.task_inc_bounds[agent_id][0], \
                                                        self.task_period_bounds[agent_id][0]],dtype=np.float32), \
                                         high=np.array([self.task_semimajor_bounds[agent_id][1], \
                                                        self.task_eccentricity_bounds[agent_id][1], \
                                                        self.task_inc_bounds[agent_id][1], \
                                                        self.max_period],dtype=np.float32))
        self.action_space = Dict([(agent_id, box_act_space[agent_id]) for agent_id in self.agent_ids])
        
        # Define the observation space
        self._obs_space_in_preferred_format = True
        #box_obs_space = Box(low=np.float32(-1e5), high=np.float32(1e5),shape=(22,))
         
        obsLow  = [0, 0]
        obsLow.extend(4*self.nAgents*[-1e5])
        obsHigh = [self.nInspectionFaces, 1e5]
        obsHigh.extend(4*self.nAgents*[1e5])
        box_obs_space = Box(low=np.array(obsLow,dtype=np.float32),high=np.array(obsHigh,dtype=np.float32))
        #box_obs_space = Box(low=np.array([0.0,0.0],dtype=np.float32),high=np.array([self.nInspectionFaces, 1e5]))
         
#        self.observation_space = Dict(
#            {
#                1: box_obs_space,
#                2: box_obs_space,
#                3: box_obs_space,
#             }
#        )
        self.observation_space = Dict([(agent_id, box_obs_space) for agent_id in self.agent_ids])

        # Create object from cpp wrapper class
        self.cppWrapper = cppWrapper()

        self.reset()

        #super().__init__()

    def init_target(self):
        # Initialize the states of the target and reference orbit
        if self.init_type == 'random':
            # Select random values to define the state

            # Define the reference orbit 
            [altitude, period, mean_motion] = self.random_state.select_ref_orbit(self.ref_altitude_bounds)

            self.ref_period = {}
            self.ref_mean_motion = {}
            self.ref_altitude = {}
            for agent_id in self.agent_ids:
                # All agents assumed to be on the same orbit as target
                self.ref_altitude[agent_id] = altitude
                self.ref_period[agent_id] = period
                self.ref_mean_motion[agent_id] = mean_motion
        else:
            # Assume altitude has been defined for the fixed cases, only need to compute mean motion and period
            # for the reference orbit
            self.ref_mean_motion = {}
            self.ref_period = {}
            for agent_id in self.agent_ids:
                # All agents assumed to be on the same orbit as target
                self.ref_period[agent_id] = orbit_utils.compute_period(self.ref_altitude[agent_id]+self.earth_radius)
                self.ref_mean_motion[agent_id] = orbit_utils.compute_mean_motion(self.ref_period[agent_id])

        # Compute the target state. This is the origin of the Hill frame
        # Orbital elements are semi-major axis, eccentricity, inclination,
        # RAAN, arguemnt of perigee, true anomaly
        # This puts in into an equatorial, circular orbit. Can add other
        # OE as arguments if more variety is desired
        OE = np.zeros(6)
        OE[0] = (self.earth_radius + self.ref_altitude[1])*1000   # Altitude should be the same for all agents
        [self.tgtPos_ECI,self.tgtVel_ECI] = OEToCartesian.OEToCartesian(0,OE,self.earth_mu*1000**3)
        self.target_state = np.concatenate((self.tgtPos_ECI,self.tgtVel_ECI))

    def init_state(self):

        if self.init_type == 'random':
            # Select random values to define the state

            # Select the semi-major axis, eccentricity, and inclination for the desired orbit 
            self.task_semimajor = dict([(agent_id, self.random_state.select_semimajor(self.task_semimajor_bounds[agent_id])) for agent_id in self.agent_ids])
            self.task_ecc = dict([(agent_id, self.random_state.select_eccentricity(self.task_eccentricity_bounds[agent_id])) for agent_id in self.agent_ids])
            self.task_inc = dict([(agent_id, self.random_state.select_inclination(self.task_inc_bounds[agent_id])) for agent_id in self.agent_ids])
            self.task_period = dict([(agent_id, self.random_state.select_period(self.task_period_bounds[agent_id])) for agent_id in self.agent_ids])
            # Define initial state for the chief
            self.chief_state = self.random_state.select_chief_state(self.task_semimajor[1], self.chief_bounds)

        else:
            # Assume task orbit parameters have been defined for the fixed case
            pass

        # Define initial state for the PRO reference orbit
        self.task_initial_state = {}
      
        for agent_id in self.agent_ids:
            if self.task_type[agent_id] == 'PRO':
                self.y0 = -1*self.task_semimajor[agent_id]
                #self.y0 = dict([(agent_id, -1*self.ref_semimajor[agent_id]) for agent_id in self.agent_ids])
                self.task_initial_state[agent_id] = [0, self.y0, 0, 0.5*self.y0*self.ref_mean_motion[agent_id], 0, np.tan(self.task_inc[agent_id]*np.pi/180.0)*0.5*self.y0*self.ref_mean_motion[agent_id]]
                # For a PRO, the task orbit period is the same as the refernece orbit
                self.task_period[agent_id] = self.ref_period[agent_id]
                self.task_period_bounds[agent_id] = [self.min_period, self.max_period]
                

        # Set the task trajectory class based on the above parameters
        self.task_trajectory = {i: taskTraj(self.task_semimajor[i],self.task_ecc[i],self.task_inc[i],self.task_period[i],self.task_type[i]) for i in self.agent_ids}


        self.initial_state_Hill = {}
        self.initial_state_ECI = {}
        # Convert initial state from Hill frame to ECI frame for the CPP code
        for agent_id in self.agent_ids:
            pos_Hill = self.task_initial_state[agent_id][0:3]
            vel_Hill = self.task_initial_state[agent_id][3:6]
            pos_ECI, vel_ECI = hill2eci.hill2eci(self.tgtPos_ECI,self.tgtVel_ECI,pos_Hill,vel_Hill)
            self.initial_state_ECI[agent_id] = np.concatenate((pos_ECI, vel_ECI))

        # Since all agents have same period, use this as the maximum stop time for the propagation
        self.stop_time = self.ref_period[1]

        self.info = dict([(agent_id, {'obs': []}) for agent_id in self.agent_ids])

        # Create dictionary to store output states, error states, actions, rewards, and orbit
        self.output_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.error_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.action_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.reward_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.orbit_states = dict([(agent_id, []) for agent_id in self.agent_ids])

        # Update the action space based on the period
        box_act_space = {}
        for agent_id in self.agent_ids:
            if self.task_type == 'PRO':
                # For PRO, eccentricity and period are fixed
                box_act_space[agent_id] = Box(low=np.array([self.task_semimajor_bounds[agent_id][0], \
                                                            0.4999, \
                                                            self.task_inc_bounds[agent_id][0], \
                                                            self.ref_period[agent_id]],dtype=np.float32), \
                                             high=np.array([self.task_semimajor_bounds[agent_id][1], \
                                                            0.5001, \
                                                            self.task_inc_bounds[agent_id][1], \
                                                            self.ref_period[agent_id]],dtype=np.float32))
            else:
                box_act_space[agent_id] = Box(low=np.array([self.task_semimajor_bounds[agent_id][0], \
                                                            self.task_eccentricity_bounds[agent_id][0], \
                                                            self.task_inc_bounds[agent_id][0], \
                                                            self.task_period_bounds[agent_id][0]],dtype=np.float32), \
                                             high=np.array([self.task_semimajor_bounds[agent_id][1], \
                                                            self.task_eccentricity_bounds[agent_id][1], \
                                                            self.task_inc_bounds[agent_id][1], \
                                                            self.task_period_bounds[agent_id][1]],dtype=np.float32))

        self.action_space = Dict([(agent_id, box_act_space[agent_id]) for agent_id in self.agent_ids])

        #print('Initializing State for New Propagation')

    def reset(self, *, seed=None, options=None):

        self.sim_time = 0
        self.step_count = 0
        self.coveredFaces = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.nCoveredFaces = dict([(agent_id, []) for agent_id in self.agent_ids])

        # Define the target state
        self.init_target()

        # Set initial observations to zero since the observations are dependent on the actions
        # which haven't been computed yet
        obs = 0
        obs = np.append(obs,0)
        for agent_id in self.agent_ids:
            obs = np.append(obs,0)
            obs = np.append(obs,0)
            obs = np.append(obs,0)
            obs = np.append(obs,0)

        # Observations must match the type from the observation space
        obs = obs.astype('float32')
        observations = {i: obs for i in self.agent_ids}

        # Initialize the cpp simulation
        [joint_limit_data, self.nFaces] = self.cppWrapper.init_cpp(self.agent_ids,initial_state,self.dof)

        # Set a max range that the agent can stray from the target before setting done flag
        # Evaluated on a per axis basis
        self.max_range = 1.5*np.max(np.abs(self.chief_state))

        info = dict([(agent_id, []) for agent_id in self.agent_ids])

        return observations, info

    def get_observation(self, agent_id, coverage, sim_time):
        # Form the observation dictionary that will be used for training

        # Should the observations be normalized
        normalized_obs = 0

        self.coveredFaces[agent_id] = np.nonzero(np.array(coverage[agent_id]))
        self.nCoveredFaces[agent_id] = np.count_nonzero(np.array(coverage[agent_id]))

        if normalized_obs == 1:            
            obsFace = self.normalize_obs(self.nCoveredFaces[agent_id],0,self.nInspectionFaces)
            obsTime = self.normalize_obs(self.sim_time,0,self.ref_period[agent_id])
        else:
            obsFace = self.nCoveredFaces[agent_id]
            obsTime = self.sim_time

        # Set the observation values
        # The number of values here must match what was used to define the observation space
        obs = obsFace
        obs = np.append(obs,obsTime)
        for agent_id in self.agent_ids:
            obs = np.append(obs,self.task_semimajor[agent_id])
            obs = np.append(obs,self.task_ecc[agent_id])
            obs = np.append(obs,self.task_inc[agent_id])
            obs = np.append(obs,self.task_period[agent_id])

        # Observations must match the type from the observation space
        obs = obs.astype('float32')
        
        return obs

    def normalize_obs(self,data,lower_bound,upper_bound):

        # Normalize the value between 0 and 1, but do not clip
        delta = upper_bound - lower_bound
        value = (data - lower_bound) / delta
        return value

    def get_reward(self, agent_id, nCovered, sim_time):

        pct_coverage = nCovered[agent_id] / self.nInspectionFaces
        pct_period = sim_time/self.ref_period[agent_id]

        params = self.reward_parameters['success']
        success_reward = reward_utils.binary_reward(params,pct_coverage)

        params = self.reward_parameters['coverage']
        coverage_reward = reward_utils.exp_reward(params,pct_coverage)

        params = self.reward_parameters['time']
        time_reward = reward_utils.power_reward(params,pct_period)

        reward = {}
        reward['success_reward'] = success_reward
        reward['coverage_reward'] = coverage_reward
        reward['time_reward'] = time_reward
        reward['total'] = success_reward + coverage_reward + time_reward
        
        return reward

    def is_done(self, agent_id):
        return 0

    def compute_errors(self, agent_id, states, coverage):

        # These aren't actually errors, but rather stats on the inspection coverage
        error_state = [self.sim_time, self.nCoveredFaces[agent_id]]
        error_state.extend(coverage)

        return np.array(error_state)

    def step(self, action):
        agent_ids = action.keys()

        # Locally track the current step number
        self.step_count += 1

        if self.step_count == 1:

            # Select the semi-major axis, eccentricity, and inclination for the desired orbit  from the actions
            self.task_semimajor = dict([(agent_id, action[agent_id][0]) for agent_id in self.agent_ids])
            self.task_ecc = dict([(agent_id, action[agent_id][1]) for agent_id in self.agent_ids])
            self.task_inc = dict([(agent_id, action[agent_id][2]) for agent_id in self.agent_ids])
            self.task_period = dict([(agent_id, action[agent_id][3]) for agent_id in self.agent_ids])

            # Initialize the agents based on the chosen task orbits
            self.init_state()
            
            # Initialize the CPP code
            mass_data = []
            mass_data, step_size = self.cppWrapper.init_cpp(self.agent_ids,self.initial_state_ECI,self.target_state,self.ref_mean_motion[1])

            # These parameters were extracted from the CPP code
            self.mass_data = mass_data
            self.step_size = step_size[0]

            self.inspectionComplete = False

        # Some scenarios will need to adjust the actions, so create a local copy
        current_action = {}

        states = {}
        coverage = {}
        dones = {}
        any_dones = {}
        # Info must only have keys for active agents because it is returned from step
        self.info = dict([(agent_id, {'obs': []}) for agent_id in agent_ids])

        # Propagate the orbit with zero delta-V
        for agent_id in agent_ids:
            current_action[agent_id] = [0]*3

        # Determine the number of steps to propagate the environment
        if self.scenario_type == 'train_dv':

            # Proapgation time determined by learning algorithm
            self.propSteps = [(int((self.ref_period[agent_id]+self.step_size) / self.step_size)) for agent_id in self.agent_ids]

        elif self.scenario_type == 'eval_dv':

            # Only propagate a single step at a time so that states can be stored for 
            # each individual step
            self.propSteps = [1 for i in range(self.nAgents)]

        else:
            # Keep the original actions
            current_action = copy.deepcopy(action)

            # Only propagate a single step at a time
            self.propSteps = [1 for i in range(self.nAgents)]

        # Execute the desired number of steps of the CPP simulation and return a new state
        #for i in range(propSteps):
        #states = {}
        #dones = {}
        #sim_time = {}
        for i in range(max(self.propSteps)):
            current_states, current_coverage, current_dones, current_sim_time = self.cppWrapper.step_cpp(agent_ids,current_action,self.stop_time,self.max_range)
            coverage = current_coverage

            # Get the observations for this step
            observations = {i: self.get_observation(i,current_coverage,current_sim_time) for i in self.agent_ids}

            # Record the states when each agent completes its propagation time
            for agent_id in agent_ids:
                states[agent_id] = current_states[agent_id]
                dones[agent_id] = current_dones[agent_id]
                if self.nCoveredFaces[agent_id] == self.nInspectionFaces:
                    self.inspectionComplete = True
                    dones[agent_id][0] = True
                any_dones[agent_id] = any([bool(dones[agent_id][i]) for i in range(2)])

            self.sim_time = current_sim_time

            # Break out if the simulation set a done flag for all agents
            if all(any_dones.values()) or self.inspectionComplete:
                print('finished run')
                break

        if self.scenario_type == 'train_dv':
            # When training, the episode is propagated the entire transfer time so it is "done" after
            # one step
            if not all(any_dones.values()):
                self.cppWrapper.terminate_cpp()
            for agent_id in agent_ids:
                dones[agent_id][0] = bool(1)
 

        # Compute errors relative to reference trajectory
        errors = {i: self.compute_errors(i,states[i],coverage[i]) for i in agent_ids}

        # Collect states and errors
        for agent_id in agent_ids:
            self.output_states[agent_id] = states[agent_id]
            self.error_states[agent_id] = errors[agent_id].tolist()
            self.action_states[agent_id] = action[agent_id].tolist()
            self.orbit_states[agent_id] = [self.ref_altitude[agent_id],self.ref_period[agent_id],self.task_semimajor[agent_id],self.task_inc[agent_id],self.task_ecc[agent_id]]
            self.orbit_states[agent_id].extend(self.chief_state.tolist())

        # Compute rewards for this step 
        step_rewards = {i: self.get_reward(i,self.nCoveredFaces,self.sim_time) for i in agent_ids}
        rewards = {}
        # Collect rewards
        for agent_id in agent_ids:
            self.reward_states[agent_id] = [step_rewards[agent_id]['success_reward'],step_rewards[agent_id]['coverage_reward'],step_rewards[agent_id]['time_reward']]
            rewards[agent_id] = step_rewards[agent_id]['total']
        
        # Not used, but required to return
        truncateds = {i: False for i in agent_ids}
        truncateds["__all__"] = all(truncateds.values())

        # Dones must be returned from step as a list of bools, not a dictionary
        for agent_id in agent_ids:
            dones[agent_id] = any([bool(dones[agent_id][i]) for i in range(2)])
        dones["__all__"] = all(dones.values())
        terminateds = dones

        return observations, rewards, terminateds, truncateds, self.info


