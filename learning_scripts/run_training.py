import sys
import os
import time
import pickle
import gc
import psutil
import numpy as np
import ray
from ray.tune.registry import register_env
from ray.tune.registry import get_trainable_cls
from ray.train import RunConfig, CheckpointConfig
from ray import air, tune
from datetime import datetime
from sat_servicing_gym_env import SatServiceEnv
from training_config import PPOAlgorithmConfig
from hyperparameter_tuning import HyperparameterTuning
from utils import data_utils
from utils.format_mat_data import format_mat_data

nAgents=1
perform_hyperparameter_tuning = False
debug = True    # You also need to give the -m -pdb arguments to python on command line

# Set initial conditions
initial_state = {}

initial_state[1] = [80,90,20]

stop_time = 80.0
stop_time = 40.0


dof = {1: 3}

time_step = 0.1    # This is the time step for training, CPP simulation may have different step size
nSteps = int(stop_time/time_step)

save_step = 100
checkpoint_step = 100
nIter = 800 

caseName = 'agent_parameters'
caseTitle = 'Agent Parameters'

if debug:
    # Run everything on a local process
    ray.init(local_mode=True)

mission = 'Task'
init_type = 'fixed'
scenario_type = 'train'
case_type = 'Benchmark_2'
nAgents = 3

# Instantiate the environment
#Create the environment
if mission == 'Transfer':
    env,task_type,caseName = create_dv_env(init_type,scenario_type,case_type,nAgents)
elif mission == 'Task':
    env,task_type,caseName = create_task_env(init_type,scenario_type,case_type,nAgents)

#register_env(
#        "multi_agent_sat_servicing", lambda _: SatServiceEnv(initial_state=initial_state,dof=dof,stop_time=stop_time,control_step_size=time_step,nAgents=nAgents)
#    )
#
#env = SatServiceEnv(initial_state=initial_state,dof=dof,stop_time=stop_time,control_step_size=time_step,nAgents=nAgents)

# Fixed hyperparameters
train_batch_size = int(500)
train_batch_size = int(100)
sgd_minibatch_size = int(train_batch_size/10)

#num_sgd_iter = 1
#clip_param = 0.3
entropy_coeff = 0.005
kl_coeff = 0.5
lambdaVal = 0.95
lr = 1e-4
lr_start = 1e-4
lr_end = 1e-5

# Define a learning rate schedule
lr_endtime = 0.8*nIter*train_batch_size

nBatches = int(nSteps/train_batch_size)
duration = nBatches

# Get the algorithm configuration settings
algoConfig = PPOAlgorithmConfig(nSteps,duration,nAgents,env,debug)


if perform_hyperparameter_tuning == True:
    HyperparameterTuning(algoConfig)

else:

    algoConfig.policies.update({'policy_1': (None, env.observation_space[1], env.action_space[1], {"lambda": lambdaVal, "kl_coeff": kl_coeff, "entropy_coeff": entropy_coeff, "gamma": 0.99, "lr": lr_start, "lr_schedule": [[0, lr_start],[lr_endtime, lr_end]]})
})
    algoConfig.training(
          train_batch_size=train_batch_size,
          sgd_minibatch_size=sgd_minibatch_size,
          model={'use_lstm':True,'fcnet_hiddens':[128,256,256,128],'fcnet_activation':'relu'}
          )

    # Now Build the config
    algo = algoConfig.build()

    # Setup directory to store ouptut
    date_time = datetime.now().strftime("%Y-%m-%d-%H-%M")
    save_dir = []
    for agent_id in env.agent_ids:
        # Specify model save path
        save_dir.append(os.path.dirname(sys.path[1])+"/data_storage/"+date_time+"/"+str(agent_id))

    time_steps = 0

    check_dir = []
    check_dir.append(os.path.dirname(sys.path[1])+"/data_storage/"+date_time+"/")

    # Restore the old (checkpointed) state.
    #checkpoint_dir = '/home/barthal/ray_results/PPO_multi_agent_sat_servicing_2023-09-07_10-39-23ftxv4usc/checkpoint_000401'
    #algo.restore(checkpoint_dir)
    #nIter=800

#    stop = {
#        "training_iteration": nIter,
#    }
#
#    tuner = tune.Tuner(
#        'PPO',
#        param_space=algoConfig.to_dict(),
#        run_config=air.RunConfig(checkpoint_config=CheckpointConfig(
#                                     num_to_keep=5,
#                                     checkpoint_score_attribute='episode_reward_mean',
#                                     checkpoint_score_order='max',
#                                     checkpoint_frequency=50,
#                                     checkpoint_at_end=True),
#                                 stop=stop, verbose=1)
#    )
#    results = tuner.fit()
#    data=results.get_dataframe()
#    best_result = results.get_best_result(metric="episode_reward_mean", mode="max")
#    best_checkpoint = best_result.checkpoint
#    print('Best Checkpoint: '+best_checkpoint.path)


    for Iter in range(algo.iteration,nIter+1): 
        print('Iteration: ', Iter)
        train_results = algo.train()
        #if time_steps >= 3000:
        #    break
        time_steps += train_results["timesteps_total"]
        #print(results['timesteps_total'])

        if not Iter % checkpoint_step:
            check_dir_inc = check_dir[0]+"checkpoint_"+str(Iter)
            if not os.path.exists(check_dir_inc):
                os.makedirs(check_dir_inc)
            # Save a training checkpoint
            checkpoint = algo.save_checkpoint(check_dir_inc)

        # Store intermediate data from training
        if not Iter % save_step:

            print('Running an evaluation case')
            eval_results = algo.evaluate()

      
            #if eval_results['evaluation']['episodes_this_iter'] > 0:
            if True:
                for i in range(env.nAgents):
                    save_dir_inc = save_dir[i]+"_"+str(Iter)
#                    #agents[i].save_model(save_dir_inc)
#                    #agents[i].save_memory(save_dir_inc)
                    agent_id = i+1
                    data_utils.save_pkl(content=eval_results['evaluation']['custom_metrics'][agent_id], fdir=save_dir_inc, fname="agent_parameters.pkl")
#                    #data_utils.save_pkl(content=train_params, fdir=os.path.dirname(save_dir_inc), fname="train_parameters.pkl")
#                    rospy.logerr("agent: "+name+" Q-net stored")

                    # Save as mat file, first must place in dictionary
                    Data = np.array(eval_results['evaluation']['custom_metrics'][agent_id])

                    matData = format_mat_data(Data,caseTitle,caseName,time_step)

                    # Create mat file
                    fileName = caseName + '.mat'
                    data_utils.save_mat(content=matData, fdir=save_dir_inc, fname=fileName)

            # auto_garbage_collection - Call the garbage collection if memory used is greater than 80% of total available memory.
            # This is called to deal with an issue in Ray not freeing up used memory.

            # pct - Default value of 80%.  Amount of memory in use that triggers the garbage collection call.
            pct = 80.0
            if psutil.virtual_memory().percent >= pct:
                gc.collect()

    #print(results)
    # Save a final checkpoint
    checkpoint = algo.save()

print('Training Complete')
