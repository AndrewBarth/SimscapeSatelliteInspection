import os
import numpy as np
import gymnasium as gym
from gymnasium import spaces
from gymnasium.spaces import Discrete, Box, Tuple, Dict
from ray.rllib.env.multi_agent_env import MultiAgentEnv
from ray.rllib.utils.typing import MultiAgentDict

from cpp_wrapper import cppWrapper
from reference_trajectory import refTraj
from compute_reward import SatServiceReward
from utils import math_utils
from utils import reward_utils


class SatServiceEnv(MultiAgentEnv):


    def __init__(self,  *args, **kwargs):


        #self.nAgents = 3
        #self.agents = {1, 2, 3}
        self.nAgents = kwargs['nAgents']
        self.agents = {1}
        self.agent_ids = set(self.agents)
        self._agent_ids = set(self.agents)
 
        # Process argements
        self.initial_state = kwargs['initial_state']
        self.dof = kwargs['dof']
        self.stop_time = kwargs['stop_time']

        # Define the reference trajectory
        self.reference_trajectory = {i: refTraj(self.stop_time) for i in self.agent_ids}

        self.terminateds = set()
        self.truncateds = set()

        self._spaces_in_preferred_format = True

        # Define the action space
        self._action_space_in_preferred_format = True
        agent_dof = self.dof[1]
#        box_act_space = Box(low=-0.02, high=0.02,
#                            shape=(agent_dof,), dtype=np.float32)
#        box_act_space1 = Box(low=np.array([-0.001,-0.0006,-0.0002]), high=np.array([0.001,0.0006,0.0002]),
#                            dtype=np.float32)
#        box_act_space1 = Box(low=np.array([-0.0001,-0.00006,-0.00002]), high=np.array([0.0001,0.00006,0.00002]),
#                            dtype=np.float32)
        box_act_space1 = Box(low=np.array([-0.005,-0.001,-0.0001]), high=np.array([0.005,0.001,0.0001]),
                            dtype=np.float32)
        box_act_space2 = Box(low=-0.001, high=0.001,
                            shape=(agent_dof,), dtype=np.float32)
        box_act_space3 = Box(low=-0.0005, high=0.0005,
                            shape=(agent_dof,), dtype=np.float32)
        self.action_space = Dict(
            {
                1: box_act_space1,
                2: box_act_space2,
                3: box_act_space3,
            }
        )
        #self.action_space = Dict([(agent_id, box_act_space) for agent_id in self.agent_ids])
        
        # Define the observation space
        self._obs_space_in_preferred_format = True
        agent_dof = self.dof[1]
        #box_obs_space = Box(low=-1e5, high=1e5,
        #                    shape=(6+2*agent_dof,), dtype=np.float32)
         
        box_obs_space = Box(low=-1e5, high=1e5,
                            shape=(6+2*agent_dof+agent_dof,))
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

        # Create dictionaries used to store output values
        self.output_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.joint_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.error_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.sim_error_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.action_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.reward_states = dict([(agent_id, []) for agent_id in self.agent_ids])

        # Create dictionary to store previous states
        self.prev_control = dict([(agent_id, []) for agent_id in self.agent_ids])

        # Create object from reward class
        self.reward = SatServiceReward(agent_ids=self.agent_ids)

        # Create object from cpp wrapper class
        self.cppWrapper = cppWrapper()

        self.reset(None,[])

        super().__init__()

    def reset(self, seed, options):

        print('Resetting Simulation')

        self.step_count = 0

        if hasattr(self, 'initial_state'):
            initial_state = self.initial_state
        else:
            initial_state = {}
            for agent_id in self.agent_ids:
                initial_state[agent_id] = [0]*self.dof[agent_id]
        
        joint_limit_data = self.cppWrapper.init_cpp(self.agent_ids,initial_state,self.dof)

        # These parameters were extracted from the CPP code
        self.joint_limits = joint_limit_data

        obs = {}
        for agent_id in self.agent_ids:
            obs[agent_id] = np.array([0.0]*(6+2*self.dof[agent_id]+self.dof[agent_id]),dtype=np.float32)

        info = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.output_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.joint_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.error_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.sim_error_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.action_states = dict([(agent_id, []) for agent_id in self.agent_ids])
        self.reward_states = dict([(agent_id, []) for agent_id in self.agent_ids])

        self.prev_control = dict([(agent_id, [0,0,0]) for agent_id in self.agent_ids])

        # Reset the reward class 
        self.reward.reset()

        return obs, info

    def get_observation(self, agent_id, states, errors, action):
        # Form the observation dictionary that will be used for training

        # Extract velocity state
        #obs = states[agent_id][3:6]

        # Add position error
        #obs.extend(errors[agent_id])

        # Extract position and orientation errors
        obs = errors[agent_id][0:6]

        # Add joint angles and rates
        start_idx=24
        end_idx=start_idx+2*self.dof[agent_id]
        obs = np.append(obs,states[agent_id][start_idx:end_idx])
        #obs = np.append(obs,action[agent_id])
        obs = np.append(obs,self.prev_control[agent_id])
        obs = obs.astype('float32')
        

        return obs

    def get_reward(self, agent_id, joint_states, error_states, action_states, prev_control):

        # Call function to get the current reward
        reward = self.reward.compute_reward(agent_id, self.step_count, self.dof, joint_states, self.joint_limits, error_states, action_states, prev_control)

        return reward

    def is_done(self, agent_id):
        return 0
        #return self.agents[agent_id] == self.goal

    def compute_errors(self, agent_id, time, states):
        
        desired_state_base = np.array(self.reference_trajectory[agent_id].compute_desired_state(time))

        # Convert the desired state to the world frame
        quat_world_base = math_utils.EulerToQuat_321(states[3:6])
        quat_base_world = math_utils.quatConj(quat_world_base);
 
        desired_state_world = np.empty_like(desired_state_base)
        desired_state_world[0:3] = math_utils.quatrotate(desired_state_base[0:3],quat_base_world)
        desired_state_world[6:9] = math_utils.quatrotate(desired_state_base[6:9],quat_base_world)
        desired_state_world[9:12] = math_utils.quatrotate(desired_state_base[9:12],quat_base_world)


        # Convert desired orientation to Modified Rodrigues Parameter format
        desired_quaternion_base = math_utils.EulerToQuat_321(desired_state_base[3:6])
        desired_quaternion_world = math_utils.quatmult(quat_world_base,desired_quaternion_base)

        #desired_mrp = math_utils.quatToMRP(math_utils.quatConj(desired_quaternion))
        desired_mrp = math_utils.quatToMRP(desired_quaternion_world)
        desired_state_world[3:6] = desired_mrp

        current_state = np.array(states[12:24])
        error_state = desired_state_world - current_state

        mrp_error = math_utils.MRPError(np.array(states[15:18]),desired_mrp)
        error_state[3:6] = mrp_error

        #if time % 10 == 0:
        #    print('Desired: ',desired_state[0:3], ' Current: ',current_state[0:3])

        return error_state

    def step(self, action):
        agent_ids = action.keys()

        second_action = action[1][1]
        action[1] = np.array([0.0, second_action, 0.0])

        # Locally track the current step number
        self.step_count += 1

        # Execute one step of the CPP simulation and return a new state
        states, sim_errors, dones, sim_time = self.cppWrapper.step_cpp(agent_ids,action,self.stop_time)

        # Compute errors relative to reference trajectory
        errors = {i: self.compute_errors(i,sim_time,states[i]) for i in agent_ids}

        # Get the observations
        observations = {i: self.get_observation(i,states,errors,action) for i in agent_ids}

        #if sim_time % 10 == 0:
        #    print('Obs: ',observations[1][0:3])

        # Collect states and errors
        for agent_id in agent_ids:
            quat_state = math_utils.MRPToQuat(np.array(states[agent_id][15:18]))
            euler_state = math_utils.quatToEuler_321(math_utils.quatConj(quat_state))
            self.joint_states[agent_id] = states[agent_id][24:24+self.dof[agent_id]]
            self.output_states[agent_id] = states[agent_id]
            self.output_states[agent_id][15:18] = euler_state
            quat_error = math_utils.MRPToQuat(np.array(errors[agent_id][3:6]))
            euler_error = math_utils.quatToEuler_321(math_utils.quatConj(quat_error))
            self.error_states[agent_id] = errors[agent_id].tolist()
            self.sim_error_states[agent_id] = sim_errors[agent_id]
            #self.error_states[agent_id][3:6] = euler_error
            self.action_states[agent_id] = action[agent_id].tolist()
            self.info[agent_id]['obs'].append(observations[agent_id])
        self.sim_time = [sim_time]

        # Compute rewards for this step 
        step_rewards = {i: self.get_reward(i,self.joint_states,self.error_states,self.action_states,self.prev_control) for i in agent_ids}

        rewards = {}
        # Collect rewards
        for agent_id in agent_ids:
            self.reward_states[agent_id] = [step_rewards[agent_id]['position_error_reward'], step_rewards[agent_id]['orientation_error_reward'], step_rewards[agent_id]['velocity_error_reward'], step_rewards[agent_id]['angular_rate_error_reward'], step_rewards[agent_id]['control_reward'],step_rewards[agent_id]['joint_limit_reward'], step_rewards[agent_id]['smoothness_reward']]
            # Total reward is used in training
            rewards[agent_id] = step_rewards[agent_id]['total']
        
        #self.prev_control[agent_id] = action_states[agent_id]
        self.prev_control = {i: self.action_states[i] for i in agent_ids}

        # Not used, but required to return
        truncated = {i: False for i in agent_ids}
        truncated["__all__"] = all(truncated.values())


        dones["__all__"] = all(dones.values())

        return observations, rewards, dones, truncated, self.info


