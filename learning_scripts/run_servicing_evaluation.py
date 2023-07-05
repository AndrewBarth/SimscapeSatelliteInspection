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
checkpoint_dir = '/home/barthal/ray_results/PPO_multi_agent_sat_servicing_2023-06-28_11-00-394pelsrt8/checkpoint_000001'

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
    npts = len(Data[0])

    # Create the time vector
    time_vec = np.arange(0,npts*time_step,time_step)
    print(npts,len(time_vec))

    # Output data in standard format
    outdata = {}
    outdata[caseName] = {}
    outdata[caseName]['Title'] = caseTitle
    outdata[caseName]['time'] = time_vec
    outdata[caseName]['sat'] = {}
    outdata[caseName]['ee'] = {}
    outdata[caseName]['arm'] = {}
    outdata[caseName]['ee']['position']    = Data[0,:,12:15]
    outdata[caseName]['ee']['orientation'] = Data[0,:,15:18]
    outdata[caseName]['ee']['velocity']    = Data[0,:,18:21]
    outdata[caseName]['ee']['ang_rate']    = Data[0,:,21:24]
    outdata[caseName]['ee']['position_error']    = Data[0,:,33:36]
    outdata[caseName]['ee']['orientation_error'] = Data[0,:,36:39]
    outdata[caseName]['ee']['velocity_error']    = Data[0,:,39:42]
    outdata[caseName]['ee']['ang_rate_error']    = Data[0,:,42:45]
    outdata[caseName]['arm']['jAngle'] = Data[0,:,24:27]
    outdata[caseName]['arm']['jRate']  = Data[0,:,27:30]
    outdata[caseName]['arm']['jCmd']   = Data[0,:,30:33]
    outdata[caseName]['arm']['jCmd']   = Data[0,:,30:33]
    outdata[caseName]['arm']['action'] = Data[0,:,45:48]
    fileName = caseName + '.mat'
    data_utils.save_mat(content=outdata, fdir=save_dir_inc, fname=fileName)

print('Evaluation Complete')
