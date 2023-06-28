import sys
import os
import time
import pickle
from ray.rllib.algorithms.ppo import PPOConfig
from ray.tune.registry import register_env
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
radius = {1: 10, 2: 15, 3: 20}
period = {1: 6*60, 2: 6*60, 3: 6*60}

time_step = 0.001    # This is fixed in the CPP code, do not change

#rollout_fragment_length = int(360)
rollout_fragment_length = "auto"

#rollout_workers = 0
rollout_workers = 2

save_step = 10 
checkpoint_step = 50
nIter = 100 


register_env(
        "multi_agent_sat_servicing", lambda _: SatServiceEnv(initial_state=initial_state,dof=dof,stop_time=stop_time,nAgents=nAgents)
    )

env = SatServiceEnv(initial_state=initial_state,dof=dof,stop_time=stop_time,nAgents=nAgents)

#train_batch_size = int(50)
train_batch_size = int(stop_time/time_step)
sgd_minibatch_size = int(train_batch_size/10)
#num_sgd_iter = 1
#clip_param = 0.3
entropy_coeff = 0.005
kl_coeff = 0.5
lambdaVal = 0.95
lr = 5e-4
lr_start = 5e-4
lr_end = 1e-5

# Define a learning rate schedule
lr_endtime = 0.6*nIter*train_batch_size

algoConfig = PPOConfig()\
    .environment('multi_agent_sat_servicing')\
    .multi_agent(
        policies={
#            "policy_1": (
#                None, env.observation_space[1], env.action_space[1], {"gamma": 0.98}
#            ),
            "policy_1": (
                None, env.observation_space[1], env.action_space[1], {"gamma": 0.98}
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
    .rollouts(
          create_env_on_local_worker=True,
          num_rollout_workers=rollout_workers,
          batch_mode="complete_episodes",
          rollout_fragment_length=rollout_fragment_length
          )\
    .callbacks(MyCallbacks)\
    .reporting(keep_per_episode_custom_metrics=True)\
    .debugging(logger_config={"type": "ray.tune.logger.TBXLogger"})\
    .training(
          train_batch_size=train_batch_size,
          sgd_minibatch_size=sgd_minibatch_size)\
    .evaluation(
            evaluation_num_workers=0,
            # Will  evaluate after training.
            evaluation_interval=None,
            evaluation_parallel_to_training=False,
            # Run 1 episodes each time evaluation runs
            evaluation_duration=1,
            evaluation_duration_unit='episodes',
            custom_evaluation_function=None,
#            evaluation_config=PPOConfig.overrides(
#                train_batch_size=5000,
#                sgd_minibatch_size=5000,
#                rollout_fragment_length=5000
#            )\
    )\
#    .build()

algoConfig.policies.update({'policy_1': (None, env.observation_space[1], env.action_space[1], {"lambda": lambdaVal, "kl_coeff": kl_coeff, "entropy_coeff": entropy_coeff, "gamma": 0.99, "lr": lr_start, "lr_schedule": [[0, lr_start],[lr_endtime, lr_end]]})
})

# Now Build the config
algo = algoConfig.build()

date_time = datetime.now().strftime("%Y-%m-%d-%H-%M")
save_dir = []
for agent_id in env.agent_ids:
        # Specify model save path
        save_dir.append(os.path.dirname(sys.path[1])+"/data_storage/"+date_time+"/"+str(agent_id))

time_steps = 0

# Restore the old (checkpointed) state.
#checkpoint_dir = '/home/barthal/ray_results/PPO_multi_agent_cubesat_2023-05-13_14-40-51vj21u4h5/checkpoint_002601'
#algo.restore(checkpoint_dir)

for Iter in range(algo.iteration,nIter): 
    print('Iteration: ', Iter)
    train_results = algo.train()
    #if time_steps >= 3000:
    #    break
    time_steps += train_results["timesteps_total"]
    #print(results['timesteps_total'])

    if not Iter % checkpoint_step:
        # Save a training checkpoint
        checkpoint = algo.save()

    # Store intermediate data from training
    if not Iter % save_step:

        print('Running an evalution case')
        eval_results = algo.evaluate()
        for i in range(env.nAgents):
            save_dir_inc = save_dir[i]+"_"+str(Iter)
#            #agents[i].save_model(save_dir_inc)
#            #agents[i].save_memory(save_dir_inc)
            agent_id = i+1
            data_utils.save_pkl(content=eval_results['evaluation']['custom_metrics'][agent_id], fdir=save_dir_inc, fname="agent_parameters.pkl")
#            #data_utils.save_pkl(content=train_params, fdir=os.path.dirname(save_dir_inc), fname="train_parameters.pkl")
#            rospy.logerr("agent: "+name+" Q-net stored")

#print(results)
# Save a final checkpoint
checkpoint = algo.save()
print('Training Complete')
