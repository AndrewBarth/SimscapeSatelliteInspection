import sys
import os
import time
import pickle
import numpy as np
import ray
from ray.rllib.algorithms.ppo import PPOConfig
from ray.tune.registry import register_env
from ray.rllib.algorithms.algorithm import Algorithm
from datetime import datetime
from create_inspection_env import create_inspection_env
from create_robotics_env import create_robotics_env
from custom_metrics import MyCallbacks
from utils import data_utils
from utils.format_mat_data import format_mat_data
from scipy.io import loadmat

values = loadmat('jointCmds.mat')



nAgents=3

mission = 'Inspection'
#mission = 'Robotics'
init_type = 'fixed'
scenario_type = 'eval'
case_type = 'Benchmark2'

# Define the checkpoint for the trained algorithm
#caseTitle = 'test_scenario'
#caseName = 'Test_Scenario'
caseTitle = 'agent_parameters'
caseName = 'agent_parameters'
checkpoint_dir = '/home/barthal/SimscapeSatelliteInspection/data_storage/2024-08-20-13-55/checkpoint_200'

# Run everything on a local process
ray.init(local_mode=True)

# Instantiate the environment
#Create the environment
if mission == 'Transfer':
    env,task_type,caseName = create_dv_env(init_type,scenario_type,case_type,nAgents)
elif mission == 'Inspection':
    env,task_type,caseName = create_inspection_env(init_type,scenario_type,case_type,nAgents)
elif mission == 'Robotics':
    env,caseName = create_robotics_env(scenario_type,nAgents)

learning_step_size = env.control_step_size


# Set up a save directory
date_time = datetime.now().strftime("%Y-%m-%d-%H-%M")
save_dir = []
#for agent_id in env.agent_ids:
for agent_id in env.active_agents:
        #7 Specify model save path
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
    Data = np.squeeze(np.array(eval_results['evaluation']['custom_metrics'][agent_id]))

    matData = format_mat_data(Data,caseTitle,caseName,mission,learning_step_size)

    # Create mat file
    fileName = caseName + '.mat'
    data_utils.save_mat(content=matData, fdir=save_dir_inc, fname=fileName)

print('Evaluation Complete')
