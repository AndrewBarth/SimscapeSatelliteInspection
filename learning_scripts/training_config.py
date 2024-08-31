import sys
import os
import time
import numpy as np
import ray
from ray.rllib.algorithms.algorithm_config import AlgorithmConfig
from ray.rllib.algorithms.ppo import PPOConfig
from ray.tune.registry import get_trainable_cls
from ray.rllib.evaluation.metrics import collect_episodes, summarize_episodes
from ray import air, tune
from custom_metrics import MyCallbacks


def PPOAlgorithmConfig(nSteps,duration,mission,nAgents,env,debug):


    #rollout_fragment_length = int(360)
    rollout_fragment_length = "auto"
    #rollout_fragment_length = nSteps

    if debug:
        rollout_workers = 0
    else:
        rollout_workers = 30

    # Adjust the episode duration
    if rollout_workers > 0:
        duration = duration*rollout_workers


    if mission == 'Inspection':
        batch_episodes = 'complete_episodes'
    else:
        batch_episodes = 'truncate_episodes'

    #algoConfig = (\
    #    get_trainable_cls('PPO')
    #    .get_default_config()
    algoConfig = PPOConfig()\
        .environment('multi_agent_sat_servicing')\
        .multi_agent(
            policies={
#                "policy_1": (
#                    None, env.observation_space[1], env.action_space[1], {"gamma": 0.98}
#                ),
                "policy_1": (
                    None, env.observation_space[1], env.action_space[1], {"gamma": 0.0}
                ),
#                "policy_2": (
#                    None, env.observation_space[2], env.action_space[2], {"gamma": 0.0}
#                ),
#                "policy_3": (
#                   None, env.observation_space[3], env.action_space[3], {"gamma": 0.0}
#                ),
#                "policy_4": (
#                   None, env.observation_space[4], env.action_space[4], {"gamma": 0.0}
#                ),
            },
            policy_mapping_fn = lambda agent_id,episode, worker, **kw: f"policy_{agent_id}",
            )\
        .framework(framework='tf',eager_tracing=True)\
        .callbacks(MyCallbacks)\
        .reporting(keep_per_episode_custom_metrics=True)\
        .rollouts(
              create_env_on_local_worker=True,
              num_rollout_workers=rollout_workers,
              batch_mode=batch_episodes,
              rollout_fragment_length=rollout_fragment_length
              )\
        .evaluation(
            evaluation_num_workers=0,
            # Will  evaluate after training.
            evaluation_interval=None,
            evaluation_parallel_to_training=False,

            # Run 1 episodes each time evaluation runs
#            evaluation_duration=duration,
            evaluation_duration=1,
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
                train_batch_size=1,
                sgd_minibatch_size=1,
            )\
        )\

    return algoConfig
