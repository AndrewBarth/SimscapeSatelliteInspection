import sys
import os
import time
import pickle
import numpy as np
from ray.rllib.algorithms.ppo import PPOConfig
from ray.tune.registry import register_env
from ray.rllib.algorithms.algorithm import Algorithm
from datetime import datetime
from sat_servicing_gym_env import SatServiceEnv
from custom_metrics import MyCallbacks
from utils import data_utils
from utils.format_mat_data import format_mat_data

nAgents=1

# Set initial conditions
initial_state = {}

initial_state[1] = [80,90,20]

stop_time = 80.0

dof = {1: 3}

time_step = 0.001    # This is fixed in the CPP code, do not change

# Define the checkpoint for the trained algorithm
caseTitle = 'test_scenario'
caseName = 'Test_Scenario'
checkpoint_dir = '/home/barthal/ray_results/PPO_multi_agent_sat_servicing_2023-07-14_08-11-16mxmvnjkh/checkpoint_000071'

# Register the enviroment with gym and create an instance of the environment
register_env(
        "multi_agent_sat_servicing", lambda _: SatServiceEnv(initial_state=initial_state,dof=dof,stop_time=stop_time,nAgents=nAgents)
    )

env = SatServiceEnv(initial_state=initial_state,dof=dof,stop_time=stop_time,nAgents=nAgents)

# Set up a save directory
date_time = datetime.now().strftime("%Y-%m-%d-%H-%M")
save_dir = []
for agent_id in env.agent_ids:
        # Specify model save path
        save_dir.append(os.path.dirname(sys.path[1])+"/data_storage/"+date_time+"/"+str(agent_id))

time_steps = 0

# Load algorithm from the desired checkpoint
algo = Algorithm.from_checkpoint(checkpoint_dir)

# Run evaluation case 
eval_results = algo.evaluate()

# Store results in both pkl and matlab format
Iter = 1
for i in range(env.nAgents):
    save_dir_inc = save_dir[i]+"_"+str(Iter)
    agent_id = i+1
    data_utils.save_pkl(content=eval_results['evaluation']['custom_metrics'][agent_id], fdir=save_dir_inc, fname="agent_parameters.pkl")
    
    # Save as mat file, first must place in dictionary
    Data = np.array(eval_results['evaluation']['custom_metrics'][agent_id])

    matData = format_mat_data(Data,caseTitle,caseName,time_step)

    # Create mat file
    fileName = caseName + '.mat'
    data_utils.save_mat(content=matData, fdir=save_dir_inc, fname=fileName)

print('Evaluation Complete')
