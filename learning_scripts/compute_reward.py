import numpy as np
from utils import math_utils
from utils import reward_utils

class SatServiceReward():


    def __init__(self, *args, **kwargs):

        self.agent_ids = kwargs['agent_ids']

        # Define position reward
        self.reward_parameters = {}
        self.reward_parameters['position_error'] = {}
        self.reward_parameters['position_error']['min_error'] = 0.0
        self.reward_parameters['position_error']['max_reward'] = 1.0
#        self.reward_parameters['position_error']['scale_factor'] = 0.02
        self.reward_parameters['position_error']['scale_factor'] = 0.1
#        self.reward_parameters['position_error']['scale_factor'] = 80.0
        self.reward_parameters['position_error']['exponent'] = -2.0
#        self.reward_parameters['position_error']['bias'] = -0.02
        self.reward_parameters['position_error']['bias'] = -0.10
#        self.reward_parameters['position_error']['bias'] = -80.0

        # Define orientation reward
        self.reward_parameters['orientation_error'] = {}
        self.reward_parameters['orientation_error']['min_error'] = 0.0
        self.reward_parameters['orientation_error']['max_reward'] = 1.0
#        self.reward_parameters['orientation_error']['scale_factor'] = -0.01
        self.reward_parameters['orientation_error']['scale_factor'] = -10000.0
        self.reward_parameters['orientation_error']['power'] = 2.0
        self.reward_parameters['orientation_error']['bias'] =  0.0

        self.reward_parameters['orientation_error'] = {}
        self.reward_parameters['orientation_error']['min_error'] = 0.0
        self.reward_parameters['orientation_error']['max_reward'] = 1.0
        self.reward_parameters['orientation_error']['scale_factor'] = -0.005
        self.reward_parameters['orientation_error']['scale_factor'] = 0.0  # DISABLED
        self.reward_parameters['orientation_error']['exponent'] = 5.0 
        self.reward_parameters['orientation_error']['bias'] =  0.0
 
        # Define velocity reward
        self.reward_parameters['velocity_error'] = {}
        self.reward_parameters['velocity_error']['min_error'] = 0.00
        self.reward_parameters['velocity_error']['max_reward'] = 1.0
        self.reward_parameters['velocity_error']['scale_factor'] = 1.0
        self.reward_parameters['velocity_error']['exponent'] = -3.0
        self.reward_parameters['velocity_error']['bias'] = -1.0

        # Define angular rate reward
        self.reward_parameters['angular_rate_error'] = {}
        self.reward_parameters['angular_rate_error']['min_error'] = 0.00
        self.reward_parameters['angular_rate_error']['max_reward'] = 1.0
        self.reward_parameters['angular_rate_error']['scale_factor'] = 1.0
        self.reward_parameters['angular_rate_error']['exponent'] = -3.0
        self.reward_parameters['angular_rate_error']['bias'] = -1.0

        # Define control reward
        self.reward_parameters['control_effort'] = {}
        #self.reward_parameters['control_effort']['scale_factor'] = -1e-1
        self.reward_parameters['control_effort']['scale_factor'] = -5
        self.reward_parameters['control_effort']['power'] = 1.0
        self.reward_parameters['control_effort']['bias'] = 0

        # Define smoothness reward
        self.reward_parameters['smoothness'] = {}
        self.reward_parameters['smoothness']['min_error'] = 0.0
        self.reward_parameters['smoothness']['max_reward'] = 1.0
        self.reward_parameters['smoothness']['scale_factor'] = 0.2
        self.reward_parameters['smoothness']['exponent'] = -2.0
        self.reward_parameters['smoothness']['bias'] = -0.2

        # Create dictionary to store previous states
        self.prev_pos_error = dict([(agent_id, [0]) for agent_id in self.agent_ids])
        self.prev_ori_error = dict([(agent_id, [0]) for agent_id in self.agent_ids])

    def reset(self):
        # Reset the previous errors
        self.prev_pos_error = dict([(agent_id, [0]) for agent_id in self.agent_ids])
        self.prev_ori_error = dict([(agent_id, [0]) for agent_id in self.agent_ids])
        

    def compute_reward(self, agent_id, step_count, dof, joint_states, joint_limits, error_states, errors, states, action_states, prev_control):

        # Get position error for this agent
        pos_error = np.array(error_states[agent_id][0:3])

        # Reward is based on the square of the error
        msq_error = np.dot(pos_error,pos_error)


        norm_error = np.linalg.norm(pos_error)
        if step_count == 1:
            delta_error = 0
        else:
            delta_error = norm_error - self.prev_pos_error[agent_id]
        self.prev_pos_error[agent_id] = norm_error

        params = self.reward_parameters['position_error']
        if norm_error < params['min_error']:
            poserr_reward = params['max_reward']
        else:
            #poserr_reward = reward_utils.exp_reward(params,delta_error)
            poserr_reward = reward_utils.exp_reward(params,norm_error)


        # Get orientation error for this agent
        #ori_error =  np.array(error_states[agent_id][3:6])
        ori_error = np.array(errors[agent_id][4:7])
        rates = np.array(states[agent_id][22:25])

        if any(np.abs(rates)) < 1e-10:
            direction = ori_error*rates/np.abs(rates)
        else:
            direction = np.array([1,0,0])


        # Reward is based on the square of the error
        msq_error = np.dot(ori_error,ori_error)

        norm_error = np.linalg.norm(ori_error)
        if step_count == 1:
            delta_error = 0
        else:
            delta_error = norm_error - self.prev_ori_error[agent_id]
        self.prev_ori_error[agent_id] = norm_error

        params = self.reward_parameters['orientation_error']
#        if norm_error < params['min_error']:
#            orierr_reward = params['max_reward']
#        else:
#            orierr_reward = reward_utils.power_reward(params,delta_error)

        orierr_reward = 0
        for i in range(3):
            if direction[i] < 0:
               orierr_reward = orierr_reward + reward_utils.exp_reward(params,-direction[i])
            else:
               orierr_reward = orierr_reward

        # Get velocity error for this agent
        vel_error = np.array(error_states[agent_id][7:10])

        # Reward is based on the square of the error
        msq_error = np.dot(vel_error,vel_error)

        norm_error = np.linalg.norm(vel_error)
        params = self.reward_parameters['velocity_error']
        if norm_error < params['min_error']:
            velerr_reward = params['max_reward']
        else:
            velerr_reward = reward_utils.exp_reward(params,norm_error)

        # Get angular rate error for this agent
        rat_error = np.array(error_states[agent_id][10:13])

        # Reward is based on the square of the error
        msq_error = np.dot(rat_error,rat_error)

        norm_error = np.linalg.norm(rat_error)
        params = self.reward_parameters['angular_rate_error']
        if norm_error < params['min_error']:
            raterr_reward = params['max_reward']
        else:
            raterr_reward = reward_utils.exp_reward(params,norm_error)

        params = self.reward_parameters['control_effort']
        control_effort = np.linalg.norm(action_states[agent_id])
        control_reward = reward_utils.power_reward(params,control_effort)

        joint_angles = np.array(joint_states[agent_id])
        joint_limits = joint_limits[agent_id]
        joint_limit_reward = 0
        for i in range(len(joint_angles)):
            if joint_angles[i] <=0:
                if joint_angles[i] < 0.98*joint_limits[i]:
                    joint_limit_reward += -0.1
            else:
                if joint_angles[i] > 0.98*joint_limits[i+len(joint_angles)]:
                    joint_limit_reward += -0.1


        smoothness_reward = 0
        if step_count > 1:
            params = self.reward_parameters['smoothness']
            pct_delta = np.abs(np.array(action_states[agent_id]) - np.array(prev_control[agent_id]))/np.array([0.005, 0.001, 0.0001])
            for i in range(dof[agent_id]):
                value = reward_utils.exp_reward(params,pct_delta[i])
                smoothness_reward = smoothness_reward + value



        reward = {}
        reward['position_error_reward'] = poserr_reward
        reward['orientation_error_reward'] = orierr_reward
        reward['velocity_error_reward'] = velerr_reward
        reward['angular_rate_error_reward'] = raterr_reward
        reward['control_reward'] = control_reward
        reward['joint_limit_reward'] = joint_limit_reward
        reward['smoothness_reward'] = smoothness_reward
        # Only include position error, orientation error, control effort, and joint limit in the training reward
        #reward['total'] = poserr_reward + orierr_reward + velerr_reward + raterr_reward + control_reward
        reward['total'] = poserr_reward + orierr_reward + control_reward + joint_limit_reward + smoothness_reward

        return reward
