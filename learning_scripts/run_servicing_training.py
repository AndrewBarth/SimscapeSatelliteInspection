import sys
import os
import time
import pickle
import gc
import psutil
import numpy as np
from ray.rllib.algorithms.algorithm_config import AlgorithmConfig
from ray.rllib.algorithms.ppo import PPOConfig
from ray.tune.registry import register_env
from ray.tune.registry import get_trainable_cls
from ray.train import RunConfig, CheckpointConfig
from ray import air, tune
from ray.tune.schedulers import PopulationBasedTraining
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
stop_time = 40.0

hyperparameter_tuning = False

dof = {1: 3}

time_step = 0.01    # This is the time step for training, CPP simulation may have different step size
nSteps = int(stop_time/time_step)

#rollout_fragment_length = int(360)
rollout_fragment_length = "auto"
#rollout_fragment_length = int((stop_time/time_step)/2)

rollout_workers = 0
#rollout_workers = 2
#rollout_workers = 6
rollout_workers = 30

save_step = 100
checkpoint_step = 100
nIter = 500 

caseName = 'agent_parameters'
caseTitle = 'Agent Parameters'

register_env(
        "multi_agent_sat_servicing", lambda _: SatServiceEnv(initial_state=initial_state,dof=dof,stop_time=stop_time,nAgents=nAgents)
    )

env = SatServiceEnv(initial_state=initial_state,dof=dof,stop_time=stop_time,nAgents=nAgents)

if hyperparameter_tuning == True:
    # Postprocess the perturbed config to ensure it's still valid
    def explore(config):
        # ensure we collect enough timesteps to do sgd
        if config["train_batch_size"] < config["sgd_minibatch_size"] * 2:
            config["train_batch_size"] = config["sgd_minibatch_size"] * 2
        # ensure we run at least one sgd iter
        if config["num_sgd_iter"] < 1:
            config["num_sgd_iter"] = 1
        return config

    hyperparam_mutations = {
        "lambda": lambda: np.random.uniform(0.9, 1.0),
        "clip_param": lambda: np.random.uniform(0.1, 0.4),
        "lr": [1e-3, 5e-4, 1e-4, 5e-5, 1e-5],
        "kl_coeff": lambda: np.random.uniform(0.3,1),
        "entropy_coeff": lambda: np.random.uniform(0.0,0.01),
        "num_sgd_iter": lambda: np.random.randint(1, 30),
        "sgd_minibatch_size": lambda: np.random.randint(5, 50),
        "train_batch_size": lambda: np.random.randint(50, 300),
    }

    pbt = PopulationBasedTraining(
        time_attr="time_total_s",
        perturbation_interval=120,
        resample_probability=0.25,
        # Specifies the mutations of these hyperparams
        hyperparam_mutations=hyperparam_mutations,
        custom_explore_fn=explore,
    )

    # Stop when we've either reached 50 training iterations or reward=-10
    stopping_criteria = {"training_iteration": 50, "episode_reward_mean": -10.0}

    # Episodes for evalutaion
    duration = 1

else:

    # Fixed hyperparameters

#    train_batch_size = int(50)
    #train_batch_size = int(stop_time/time_step)
    #sgd_minibatch_size = int(train_batch_size/1000)
    #train_batch_size = int(80000)
    train_batch_size = int(500)
    sgd_minibatch_size = int(train_batch_size/10)

    #num_sgd_iter = 1
    #clip_param = 0.3
    entropy_coeff = 0.005
    kl_coeff = 0.5
    lambdaVal = 0.95
    lr = 5e-5
    lr_start = 5e-5
    lr_end = 1e-5

    # Define a learning rate schedule
    lr_endtime = 0.6*nIter*train_batch_size

    nBatches = int(nSteps/train_batch_size)
    if rollout_workers == 0:
        duration = nBatches
    else:
        duration = nBatches*rollout_workers

#algoConfig = (\
#    get_trainable_cls('PPO')
#    .get_default_config()
algoConfig = PPOConfig()\
    .environment('multi_agent_sat_servicing')\
    .multi_agent(
        policies={
#            "policy_1": (
#                None, env.observation_space[1], env.action_space[1], {"gamma": 0.98}
#            ),
            "policy_1": (
                None, env.observation_space[1], env.action_space[1], {"gamma": 0.99}
            ),
#            "policy_2": (
#                None, env.observation_space[2], env.action_space[2], {"gamma": 0.99}
#            ),
#            "policy_3": (
#               None, env.observation_space[3], env.action_space[3], {"entropy_coeff": 0.005, "gamma": 0.98}
#            ),
        },
        policy_mapping_fn = lambda agent_id,episode, worker, **kw: f"policy_{agent_id}",
        )\
    .framework(framework='tf',eager_tracing=True)\
    .rollouts(
          create_env_on_local_worker=True,
          num_rollout_workers=rollout_workers,
          batch_mode="truncate_episodes",
          rollout_fragment_length=rollout_fragment_length
          )\
    .callbacks(MyCallbacks)\
    .reporting(keep_per_episode_custom_metrics=True)\
    .debugging(logger_config={"type": "ray.tune.logger.TBXLogger"})\
    .evaluation(
            evaluation_num_workers=0,
            # Will  evaluate after training.
            evaluation_interval=None,
            evaluation_parallel_to_training=False,
            # Run 1 episodes each time evaluation runs
            evaluation_duration=duration,
            evaluation_duration_unit='episodes',
            #evaluation_duration=nSteps,
            #evaluation_duration_unit='timesteps',
            custom_evaluation_function=None,
            #evaluation_config=dict(
            evaluation_config=PPOConfig.overrides(
                explore=False,
                evaluation_num_workers=0,
                evaluation_interval=None,
                evaluation_parallel_to_training=False,
                #evaluation_duration=nSteps,
                #evaluation_duration_unit='timesteps',
                custom_evaluation_function=None,
                #horizon=nSteps,
                num_rollout_workers=0,
                rollout_fragment_length=nSteps,
                train_batch_size=nSteps,
            )\
    )\
#    .build()
                #train_batch_size=5000,
                #sgd_minibatch_size=5000,
                #rollout_fragment_length=5000
if hyperparameter_tuning == True:
    tuner = tune.Tuner(
        "PPO",
        tune_config=tune.TuneConfig(
            metric="episode_reward_mean",
            mode="max",
            scheduler=pbt,
            num_samples=10,
            #num_samples=1 if args.smoke_test else 2,
        ),
        param_space=algoConfig.to_dict(),

        run_config=air.RunConfig(stop=stopping_criteria,
            checkpoint_config=air.CheckpointConfig(
               checkpoint_score_attribute="mean_accuracy",
               num_to_keep=4),
        ),
    )

    # Run hyperparameter tuning
    results = tuner.fit()

    # Collect and print results from hyperparameter tuning
    best_result = results.get_best_result()

    print("Best performing trial's final set of hyperparameters:\n")
    pprint.pprint(
        {k: v for k, v in best_result.config.items() if k in hyperparam_mutations}
    )

    print("\nBest performing trial's final reported metrics:\n")

    metrics_to_print = [
        "episode_reward_mean",
        "episode_reward_max",
        "episode_reward_min",
        "episode_len_mean",
    ]
    pprint.pprint({k: v for k, v in best_result.metrics.items() if k in metrics_to_print})

else:

    algoConfig.policies.update({'policy_1': (None, env.observation_space[1], env.action_space[1], {"lambda": lambdaVal, "kl_coeff": kl_coeff, "entropy_coeff": entropy_coeff, "gamma": 0.99, "lr": lr_start, "lr_schedule": [[0, lr_start],[lr_endtime, lr_end]]})
})
    algoConfig.training(
          train_batch_size=train_batch_size,
          sgd_minibatch_size=sgd_minibatch_size,
          model={'use_lstm':True,'fcnet_hiddens':[128,256,256,128],'fcnet_activation':'relu'}
          )
    #algoConfig.evaluation_config=PPOConfig.overrides(
    #                horizon=nSteps,
    #                rollout_fragment_length=nSteps,
    #                train_batch_size=nSteps,
    #            )

    # Now Build the config
    algo = algoConfig.build()

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
