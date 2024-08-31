import sys
import os
import glob
import subprocess
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

#data_dir = '/home/barthal/SimscapeSatelliteInspection/data_storage/2024-08-27-07-50'
#data_dir = '/home/barthal/SimscapeSatelliteInspection/data_storage/2024-08-27-13-14'  # G(3,3)
#data_dir = '/home/barthal/SimscapeSatelliteInspection/data_storage/2024-08-29-11-47'  # G(1,1)
data_dir = '/home/barthal/SimscapeSatelliteInspection/data_storage/2024-08-29-16-08'  # G(1,1) 5m radius
x=glob.glob('checkpoint*',root_dir=data_dir)
val=[x[i].split('_')[-1] for i in range(len(x))]
ival=np.array([int(val[i]) for i in range(len(val))])
idx=np.argsort(ival)
episodes=[ival[idx[i]] for i in range(len(ival))]
reldirs=[x[idx[i]] for i in range(len(idx))]

# Run everything on a local process
ray.init(local_mode=True)

# Record the current data and time
date_time = datetime.now().strftime("%Y-%m-%d-%H-%M")

for ep in range(len(episodes)):

    # Instantiate the environment
    #Create the environment
    if mission == 'Transfer':
        env,task_type,caseName = create_dv_env(init_type,scenario_type,case_type,nAgents)
    elif mission == 'Inspection':
        env,task_type,caseName = create_inspection_env(init_type,scenario_type,case_type)
    elif mission == 'Robotics':
        env,caseName = create_robotics_env(scenario_type,nAgents)

    learning_step_size = env.control_step_size


    # Set up a save directory
    save_dir = []
    for agent_id in env.active_agents:
        # Specify model save path
        save_dir.append(os.path.dirname(sys.path[1])+"/data_storage/"+date_time+"/"+str(agent_id))

    time_steps = 0

    # Load algorithm from the desired checkpoint
    checkpoint_dir = data_dir+'/'+reldirs[ep]
    algo = Algorithm.from_checkpoint(checkpoint_dir)

    # Run evaluation case 
    print('Running case: ',checkpoint_dir)
    eval_results = algo.evaluate()

    # Store results in both pkl and matlab format
    Iter = 1
    for i in range(len(env.active_agents)):
        save_dir_inc = save_dir[i]+"_"+str(episodes[ep])
        agent_id = i+1
        data_utils.save_pkl(content=eval_results['evaluation']['custom_metrics'][agent_id], fdir=save_dir_inc, fname="agent_parameters.pkl")

        try:
            # Save as mat file, first must place in dictionary
            Data = np.squeeze(np.array(eval_results['evaluation']['custom_metrics'][agent_id]))

            matData = format_mat_data(Data,caseTitle,caseName,mission,learning_step_size)

            # Create mat file
            fileName = caseName + '.mat'
            data_utils.save_mat(content=matData, fdir=save_dir_inc, fname=fileName)
        except: 
            print('Error saving mat file for agent: ',agent_id)

print('Evaluation Complete')
