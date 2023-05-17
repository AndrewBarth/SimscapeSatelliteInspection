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

nAgents=3

# Set initial conditions
initial_state = {}

initial_state[1] = [80]
initial_state[2] = [90]
initial_state[3] = [20]

stop_time = 80.0

radius = {1: 10, 2: 15, 3: 20}
period = {1: 6*60, 2: 6*60, 3: 6*60}

time_step = 0.5    # This is fixed in the CPP code, do not change
train_batch_size = int(stop_time/time_step)
#rollout_fragment_length = int(stop_time/time_step)
#train_batch_size = int(1000)

train_batch_size = int(7200);
#rollout_fragment_length = int(360)
rollout_fragment_length = "auto"
sgd_minibatch_size = int(train_batch_size/10)
rollout_workers = 0
#rollout_workers = 2
#save_step = 100 
save_step = 50 
checkpoint_step = 200
nIter = 5000


register_env(
        "multi_agent_sat_servicing", lambda _: SatServiceEnv(initial_state=initial_state,stop_time=stop_time,radius=radius,nAgents=nAgents,period=period)
    )

env = SatServiceEnv(initial_state=initial_state,stop_time=stop_time,radius=radius,nAgents=nAgents,period=period)

algo = PPOConfig()\
    .environment('multi_agent_sat_servicing')\
    .multi_agent(
        policies={
#            "policy_1": (
#                None, env.observation_space[1], env.action_space[1], {"gamma": 0.98}
#            ),
            "policy_1": (
                None, env.observation_space[1], env.action_space[1], {"gamma": 0.98}
            ),
            "policy_2": (
                None, env.observation_space[2], env.action_space[2], {"gamma": 0.99}
            ),
            "policy_3": (
               None, env.observation_space[3], env.action_space[3], {"entropy_coeff": 0.005, "gamma": 0.98}
            ),
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
            evaluation_duration=int(stop_time/time_step),
            evaluation_duration_unit='timesteps',
            custom_evaluation_function=None,
#            evaluation_config=PPOConfig.overrides(
#                train_batch_size=5000,
#                sgd_minibatch_size=5000,
#                rollout_fragment_length=5000
#            )\
    )\
    .build()

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
