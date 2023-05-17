import os
import numpy as np
import gymnasium as gym
from gymnasium import spaces
from gymnasium.spaces import Discrete, Box, Tuple, Dict
from ray.rllib.env.multi_agent_env import MultiAgentEnv
from ray.rllib.utils.typing import MultiAgentDict

from cpp_wrapper import cppWrapper
from reference_trajectory import refTraj


class SatServiceEnv(MultiAgentEnv):


    def __init__(self,  *args, **kwargs):


        #self.nAgents = 3
        #self.agents = {1, 2, 3}
        self.nAgents = kwargs['nAgents']
        self.agents = {1,2,3}
        self.agent_ids = set(self.agents)
 
        # Process argements
        self.initial_state = kwargs['initial_state']
        self.stop_time = kwargs['stop_time']

        # Define the reference trajectory
        self.ref_radius = kwargs['radius']
        self.ref_period = kwargs['period']
        self.reference_trajectory = {i: refTraj(self.ref_radius[i],self.ref_period[i]) for i in self.agent_ids}

        self.reward_parameters = {}
        self.reward_parameters['position_error'] = {}
        self.reward_parameters['position_error']['min_error'] = 0.1
        self.reward_parameters['position_error']['max_reward'] = 1.0
        #self.reward_parameters['position_error']['scale_factor'] = -1e-3
        self.reward_parameters['position_error']['scale_factor'] = -0.1
        self.reward_parameters['position_error']['exponent'] = 0.03

        self.reward_parameters['velocity_error'] = {}
        self.reward_parameters['velocity_error']['min_error'] = 0.005
        self.reward_parameters['velocity_error']['max_reward'] = 1.0
        #self.reward_parameters['velocity_error']['scale_factor'] = -10.0
        self.reward_parameters['velocity_error']['scale_factor'] = -0.1
        self.reward_parameters['velocity_error']['exponent'] = 3.0 

        self.reward_parameters['control_effort'] = {}
        #self.reward_parameters['control_effort']['scale_factor'] = -1e-1
        self.reward_parameters['control_effort']['scale_factor'] = -5

        self.terminateds = set()
        self.truncateds = set()

        self._spaces_in_preferred_format = True

        # Define the action space
        self._action_space_in_preferred_format = True
        box_act_space = Box(low=-0.02, high=0.02,
                            shape=(3,), dtype=np.float32)
#        self.action_space = Dict(
#            {
#                1: box_act_space,
#                2: box_act_space,
#                3: box_act_space,
#            }
#        )
        self.action_space = Dict([(agent_id, box_act_space) for agent_id in self.agent_ids])
        
        # Define the observation space
        self._obs_space_in_preferred_format = True
        box_obs_space = Box(low=-1e5, high=1e5,
                            shape=(6,), dtype=np.float32)
         
#        self.observation_space = Dict(
#            {
#                1: box_obs_space,
#                2: box_obs_space,
#                3: box_obs_space,
#             }
#        )
        self.observation_space = Dict([(agent_id, box_obs_space) for agent_id in self.agent_ids])

#        self.info = {1: [], 2: [], 3: []}
#        self.agents = {1: (4, 0), 2: (0, 4)}
        self.info = dict([(agent_id, {'obs': []}) for agent_id in self.agent_ids])
#        self.info = {1: {'obs': []}, 2: {'obs': []}, 3: {'obs': []}}

        # Create dictionary to store output states
        self.output_states = dict([(agent_id, []) for agent_id in self.agent_ids])

        # Create dictionary to store error states
        self.error_states = dict([(agent_id, []) for agent_id in self.agent_ids])

        # Create dictionary to store actions
        self.action_states = dict([(agent_id, []) for agent_id in self.agent_ids])

        # Create dictionary to store rewards
        self.reward_states = dict([(agent_id, []) for agent_id in self.agent_ids])

        # Store cumulative thrust
        self.cumulative_thrust = []

        # Create object from cpp wrapper class
        self.cppWrapper = cppWrapper()

        self.reset(None,[])

        super().__init__()

    def reset(self, seed, options):

        if hasattr(self, 'initial_state'):
            initial_state = self.initial_state
        else:
            initial_state = {}
            for agent_id in self.agent_ids:
                initial_state[agent_id] = [0]*6
        
        self.cppWrapper.init_cpp(self.agent_ids,initial_state)

        obs = {}
        for agent_id in self.agent_ids:
            obs[agent_id] = np.array([0.0]*6,dtype=np.float32)

        info = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.output_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.error_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.action_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.reward_states = dict([(agent_id, []) for agent_id in self.agent_ids])

        self.cumulative_thrust = []

        return obs, info

    def get_observation(self, agent_id, states, errors):
        # Form the observation dictionary that will be used for training

        # Extract velocity state
        #obs = states[agent_id][3:6]

        # Add position error
        #obs.extend(errors[agent_id])

        # Extract position and velocity errors
        obs = errors[agent_id][0:6]

        return obs

    def get_reward(self, agent_id, error_states, action_states):

        # Get position error for this agent
        pos_error = np.array(error_states[agent_id][0:3])

        # Reward is based on the square of the error
        msq_error = np.dot(pos_error,pos_error)

        #params = self.reward_parameters['position_error']
        #if msq_error < params['min_error']:
        #    poserr_reward = params['max_reward']
        #else:
        #    poserr_reward = params['scale_factor']*msq_error

        norm_error = np.linalg.norm(pos_error)
        params = self.reward_parameters['position_error']
        if norm_error < params['min_error']:
            poserr_reward = params['max_reward']
        else:
            poserr_reward = params['scale_factor']*np.exp(params['exponent']*norm_error)

        # Get velocity error for this agent
        vel_error = np.array(error_states[agent_id][3:6])

        # Reward is based on the square of the error
        msq_error = np.dot(vel_error,vel_error)

        #params = self.reward_parameters['velocity_error']
        #if msq_error < params['min_error']:
        #    velerr_reward = params['max_reward']
        #else:
        #    velerr_reward = params['scale_factor']*msq_error

        norm_error = np.linalg.norm(vel_error)
        params = self.reward_parameters['velocity_error']
        if norm_error < params['min_error']:
            velerr_reward = params['max_reward']
        else:
            velerr_reward = params['scale_factor']*np.exp(params['exponent']*norm_error)


        params = self.reward_parameters['control_effort']
        control_effort = np.linalg.norm(action_states[agent_id])
        control_reward = params['scale_factor']*control_effort

        reward = {}
        reward['position_error_reward'] = poserr_reward
        reward['velocity_error_reward'] = velerr_reward
        reward['control_reward'] = control_reward
        reward['total'] = poserr_reward + velerr_reward + control_reward
        
        return reward

    def is_done(self, agent_id):
        return 0
        #return self.agents[agent_id] == self.goal

    def compute_errors(self, agent_id, time, states):
        
        desired_state = np.array(self.reference_trajectory[agent_id].compute_desired_state(time))
        current_state = np.array(states[0:6])
        error_state = desired_state - current_state

        return error_state

    def step(self, action):
        agent_ids = action.keys()

        # Execute one step of the CPP simulation and return a new state
        states, dones, sim_time = self.cppWrapper.step_cpp(agent_ids,action,self.stop_time)

        # Compute errors relative to reference trajectory
        errors = {i: self.compute_errors(i,sim_time,states[i]) for i in agent_ids}

        # Get the observations
        observations = {i: self.get_observation(i,states,errors) for i in agent_ids}

        # Collect states and errors
        for agent_id in agent_ids:
            self.output_states[agent_id] = states[agent_id]
            self.error_states[agent_id] = errors[agent_id].tolist()
            self.action_states[agent_id] = action[agent_id].tolist()
            self.action_states[agent_id][2] = 0
            self.info[agent_id]['obs'].append(observations[agent_id])

        # Compute rewards for this step 
        step_rewards = {i: self.get_reward(i,self.error_states,self.action_states) for i in agent_ids}

        rewards = {}
        # Collect rewards
        for agent_id in agent_ids:
            self.reward_states[agent_id] = [step_rewards[agent_id]['position_error_reward'], step_rewards[agent_id]['velocity_error_reward'], step_rewards[agent_id]['control_reward']]
            rewards[agent_id] = step_rewards[agent_id]['total']
        
        # Not used, but required to return
        truncated = {i: False for i in agent_ids}
        truncated["__all__"] = all(truncated.values())


        dones["__all__"] = all(dones.values())

        return observations, rewards, dones, truncated, self.info

