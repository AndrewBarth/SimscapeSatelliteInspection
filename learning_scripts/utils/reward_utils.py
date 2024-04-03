import numpy as np

# A collection of generic functions to compute rewards
# based on the parameter settings

def exp_reward(params,data):

    # Implement an exponential function
    reward = params['scale_factor']*np.exp(params['exponent']*data)+params['bias']
    
    return reward

def power_reward(params,data):

    # Implement a power function
    reward = params['scale_factor']*(data**params['power'])+params['bias']
    
    return reward

def binary_reward(params,data):

    # Implement a binary function
    if data >= params['threshold']:
        reward = params['reward_value']
    else: 
        reward = 0
    
    return reward

