import sys
import os
import time
import pickle
import gc
import psutil
import numpy as np
import ray
import faulthandler; faulthandler.enable()
from ray.tune.registry import register_env
from ray.tune.registry import get_trainable_cls
from ray.train import RunConfig, CheckpointConfig
from ray import air, tune
from datetime import datetime
from create_inspection_env import create_inspection_env
from create_robotics_env import create_robotics_env
from training_config import PPOAlgorithmConfig
from hyperparameter_tuning import HyperparameterTuning
from utils import data_utils
from utils.format_mat_data import format_mat_data

perform_hyperparameter_tuning = False
debug = False    # You also need to give the -m -pdb arguments to python on command line
#debug = True


save_step = 10
checkpoint_step = 10
nIter = 400 

#save_step = 20 
#checkpoint_step = 20
#nIter = 2 

caseName = 'agent_parameters'
caseTitle = 'Agent Parameters'

if debug:
    # Run everything on a local process
    ray.init(local_mode=True)
else:
    ray.init()

#mission = 'Inspection'
mission = 'Robotics'

init_type = 'fixed'
#init_type = 'random'
scenario_type = 'train'
case_type = 'Benchmark2'

# Instantiate the environment
#Create the environmet
if mission == 'Transfer':
    env,task_type,caseName = create_dv_env(init_type,scenario_type,case_type,nAgents)
    nAgents=3
elif mission == 'Inspection':
    env,task_type,caseName = create_inspection_env(init_type,scenario_type,case_type)
    nAgents=3
elif mission == 'Robotics':
    nAgents = 1
    env,caseName = create_robotics_env(scenario_type,nAgents)

learning_step_size = env.control_step_size

# Fixed hyperparameters
# Cubesat inspection values
if mission == 'Inspection':
    #train_batch_size = int(400)
    train_batch_size = int(30)
    sgd_minibatch_size = int(train_batch_size/5)
    nSteps = 1
    duration = 1
    gamma = 0.0
    # Define a learning rate schedule
    lr = 1e-4
    lr_start = 1e-4
    lr_end = 1e-5
    lr_endtime = 0.8*nIter*train_batch_size

elif mission == 'Robotics':
    train_batch_size = int(500)
    #train_batch_size = nSteps
    sgd_minibatch_size = int(train_batch_size/10)
    nSteps = int(env.stop_time/learning_step_size)
    nBatches = int(nSteps/train_batch_size)
    duration = nBatches
    gamma = 0.99
    # Define a learning rate schedule
    lr = 1e-4
    lr_start = 1e-4
    lr_end = 5e-6
    lr_endtime = 0.8*nIter*train_batch_size

#num_sgd_iter = 1
clip_param = 0.3
entropy_coeff = 0.005
kl_coeff = 0.5
lambdaVal = 0.95


# Get the algorithm configuration settings
algoConfig = PPOAlgorithmConfig(nSteps,duration,mission,nAgents,env,debug)


if perform_hyperparameter_tuning == True:
    HyperparameterTuning(algoConfig)

else:

    algoConfig.policies.update({'policy_1': (None, env.observation_space[1], env.action_space[1], {"lambda": lambdaVal, "kl_coeff": kl_coeff, "entropy_coeff": entropy_coeff, "gamma": gamma, "clip_param": clip_param, "lr": lr_start, "lr_schedule": [[0, lr_start],[lr_endtime, lr_end]]})
})
#    algoConfig.policies.update({'policy_1': (None, env.observation_space[1], env.action_space[1], {"lambda": lambdaVal, "kl_coeff": kl_coeff, "entropy_coeff": entropy_coeff, "gamma": gamma, "lr": lr_start, "lr_schedule": [[0, lr_start],[lr_endtime, lr_end]]})
#})
#    algoConfig.policies.update({'policy_2': (None, env.observation_space[2], env.action_space[2], {"lambda": lambdaVal, "kl_coeff": kl_coeff, "entropy_coeff": entropy_coeff, "gamma": 0.0, "lr": lr_start, "lr_schedule": [[0, lr_start],[lr_endtime, lr_end]]})
#})
#    algoConfig.policies.update({'policy_3': (None, env.observation_space[3], env.action_space[3], {"lambda": lambdaVal, "kl_coeff": kl_coeff, "entropy_coeff": entropy_coeff, "gamma": 0.0, "lr": lr_start, "lr_schedule": [[0, lr_start],[lr_endtime, lr_end]]})
#})
#    algoConfig.policies.update({'policy_4': (None, env.observation_space[4], env.action_space[4], {"lambda": lambdaVal, "kl_coeff": kl_coeff, "entropy_coeff": entropy_coeff, "gamma": 0.0, "lr": lr_start, "lr_schedule": [[0, lr_start],[lr_endtime, lr_end]]})
#})
    algoConfig.training(
          train_batch_size=train_batch_size,
          sgd_minibatch_size=sgd_minibatch_size,
          model={'max_seq_len':2,'use_lstm':True,'fcnet_hiddens':[128,256,256,128],'fcnet_activation':'relu'}
          )

    # Now Build the config
    algo = algoConfig.build()

    # Setup directory to store ouptut
    date_time = datetime.now().strftime("%Y-%m-%d-%H-%M")
    save_dir = []
    for agent_id in env.active_agents:
        # Specify model save path
        save_dir.append(os.path.dirname(sys.path[1])+"/data_storage/"+date_time+"/"+str(agent_id))

    time_steps = 0

    check_dir = []
    check_dir.append(os.path.dirname(sys.path[1])+"/data_storage/"+date_time+"/")

    # Restore the old (checkpointed) state.
    #checkpoint_dir = '/home/barthal/SimscapeSatelliteInspection/data_storage/2024-09-18-09-42/checkpoint_200'
    #algo.restore(checkpoint_dir)
    #nIter=400

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

        if not Iter % checkpoint_step or Iter == nIter:
            check_dir_inc = check_dir[0]+"checkpoint_"+str(Iter)
            if not os.path.exists(check_dir_inc):
                os.makedirs(check_dir_inc)
            # Save a training checkpoint
            checkpoint = algo.save_checkpoint(check_dir_inc)

        # Store intermediate data from training
        if not Iter % save_step or Iter == nIter:

            print('Running an evaluation case')
            eval_results = algo.evaluate()

      
            #if eval_results['evaluation']['episodes_this_iter'] > 0:
            if True:
                for i in range(len(env.active_agents)):
                    save_dir_inc = save_dir[i]+"_"+str(Iter)
#                    #agents[i].save_model(save_dir_inc)
#                    #agents[i].save_memory(save_dir_inc)
                    agent_id = i+1
                    data_utils.save_pkl(content=eval_results['evaluation']['custom_metrics'][agent_id], fdir=save_dir_inc, fname="agent_parameters.pkl")
#                    #data_utils.save_pkl(content=train_params, fdir=os.path.dirname(save_dir_inc), fname="train_parameters.pkl")
#                    rospy.logerr("agent: "+name+" Q-net stored")

                    # Save as mat file, first must place in dictionary
                    #if len(eval_results['evaluation']['custom_metrics'][agent_id][0]) > 0:
                    try:
                        Data = np.squeeze(np.array(eval_results['evaluation']['custom_metrics'][agent_id]))

                        matData = format_mat_data(Data,caseTitle,caseName,mission,learning_step_size)

                        # Create mat file
                        fileName = caseName + '.mat'
                        data_utils.save_mat(content=matData, fdir=save_dir_inc, fname=fileName)
                    except:
                        print('Error saving mat file for agent: ',agent_id)

            # auto_garbage_collection - Call the garbage collection if memory used is greater than 80% of total available memory.
            # This is called to deal with an issue in Ray not freeing up used memory.

            # pct - Default value of 80%.  Amount of memory in use that triggers the garbage collection call.
            pct = 80.0
            if psutil.virtual_memory().percent >= pct:
                gc.collect()

    # Save a final checkpoint
    check_dir_inc = check_dir[0]+"checkpoint_"+str(Iter)
    checkpoint = algo.save()

print('Training Complete')
