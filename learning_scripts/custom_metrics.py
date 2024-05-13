"""Example of using RLlib's debug callbacks.
Here we use callbacks to track the average CartPole pole angle magnitude as a
custom metric.
"""

from typing import Dict, Tuple
import argparse
import numpy as np
import os

import ray
from ray import air, tune
from ray.rllib.algorithms.callbacks import DefaultCallbacks
from ray.rllib.env import BaseEnv
from ray.rllib.evaluation import Episode, RolloutWorker
from ray.rllib.policy import Policy
from ray.rllib.policy.sample_batch import SampleBatch

parser = argparse.ArgumentParser()
parser.add_argument(
    "--framework",
    choices=["tf", "tf2", "torch"],
    default="torch",
    help="The DL framework specifier.",
)
parser.add_argument("--stop-iters", type=int, default=2000)


class MyCallbacks(DefaultCallbacks):

    @staticmethod
    def get_info(base_env, episode):
        """Return the info dict for the given base_env and episode"""
        # different treatment for MultiAgentEnv where we need to get the info dict from a specific UE
        if hasattr(base_env, 'envs'):
            # get the info dict for the first UE (it's the same for all)
            #ue_id = base_env.envs[0].ue_list[0].id
            #info = episode.last_info_for(ue_id)
            info = episode._last_infos

        else:
            #info = episode.last_info_for()
            info = episode._last_infos
        return info

    def on_episode_start(
        self,
        *,
        worker: RolloutWorker,
        base_env: BaseEnv,
        policies: Dict[str, Policy],
        episode: Episode,
        env_index: int,
        **kwargs
    ):
        # Make sure this episode has just been started (only initial obs
        # logged so far).
#        assert episode.length == 0, (
#            "ERROR: `on_episode_start()` callback should be called right "
#            "after env reset!"
#        )
        print("episode {} (env-idx={}) started.".format(episode.episode_id, env_index))
#        episode.user_data["output_states"] = {}
#        episode.user_data["pole_angles"] = []
#        episode.hist_data["pole_angles"] = []
        episode.user_data["output_states"] = {}
        episode.user_data["error_states"] = {}
        episode.user_data["sim_error_states"] = {}
        episode.user_data["action_states"] = {}
        episode.user_data["reward_states"] = {}
        episode.user_data["ref_states"] = {}
        episode.user_data["orbit_states"] = {}
        episode.user_data["sim_time"] = []
        for agent_key in worker.env.active_agents:
            episode.user_data["output_states"][agent_key] = [] 
            episode.user_data["error_states"][agent_key] = []
            episode.user_data["sim_error_states"][agent_key] = []
            episode.user_data["action_states"][agent_key] = []
            episode.user_data["reward_states"][agent_key] = []
            episode.user_data["ref_states"][agent_key] = []
            episode.user_data["orbit_states"][agent_key] = []

    def on_episode_step(
        self,
        *,
        worker: RolloutWorker,
        base_env: BaseEnv,
        policies: Dict[str, Policy],
        episode: Episode,
        env_index: int,
        **kwargs
    ):
        # Make sure this episode is ongoing.
        assert episode.length > 0, (
            "ERROR: `on_episode_step()` callback should not be called right "
            "after env reset!"
        )
        agent_keys = worker.env.output_states.keys()

        for agent_key in agent_keys:
            episode.user_data["output_states"][agent_key].append(worker.env.output_states[agent_key])
            episode.user_data["error_states"][agent_key].append(worker.env.error_states[agent_key])
            episode.user_data["sim_error_states"][agent_key].append(worker.env.sim_error_states[agent_key])
            episode.user_data["action_states"][agent_key].append(worker.env.action_states[agent_key])
            episode.user_data["reward_states"][agent_key].append(worker.env.reward_states[agent_key])
            episode.user_data["ref_states"][agent_key].append(worker.env.ref_states[agent_key])
            episode.user_data["orbit_states"][agent_key].append(worker.env.orbit_states[agent_key])
            episode.user_data["sim_time"].append([worker.env.sim_time])

    def on_episode_end(
        self,
        *,
        worker: RolloutWorker,
        base_env: BaseEnv,
        policies: Dict[str, Policy],
        episode: Episode,
        env_index: int,
        **kwargs
    ):
        print("reached episode end")
        # Check if there are multiple episodes in a batch, i.e.
        # "batch_mode": "truncate_episodes".
#        if worker.policy_config["batch_mode"] == "truncate_episodes":
#            # Make sure this episode is really done.
#            assert episode.batch_builder.policy_collectors["default_policy"].batches[
#                -1
#            ]["dones"][-1], (
#                "ERROR: `on_episode_end()` should only be called "
#                "after episode is done!"
#            )
#        pole_angle = np.mean(episode.user_data["pole_angles"])
#        print(
#            "episode {} (env-idx={}) ended with length {} and pole "
#            "angles {}".format(
#                episode.episode_id, env_index, episode.length, pole_angle
#            )
#        )
        # log the sum of scalar metrics over an episode as metric
        agent_keys = episode.user_data['output_states']
#        output_states = episode.user_data['output_states']
#        error_states = episode.user_data['error_states']
#        action_states = episode.user_data['action_states']
#        reward_states = episode.user_data['reward_states']
        
        #for metric_key, value in episode.user_data.items():
        for agent_key in agent_keys:
            combined_metrics = []
            for (s,t,u,v,w,x,y,z) in zip(episode.user_data['output_states'][agent_key], episode.user_data['error_states'][agent_key], episode.user_data['action_states'][agent_key],episode.user_data['reward_states'][agent_key], episode.user_data['ref_states'][agent_key], episode.user_data['orbit_states'][agent_key], episode.user_data['sim_time'],episode.user_data['sim_error_states'][agent_key]):
                combined_metrics.append(s+t+u+v+w+x+y+z)

#            for metric_key in episode.user_data.keys():
#                #combined_metrics.append(np.array(episode.user_data[metric_key][agent_key]))
#                for x in episode.user_data[metric_key][agent_key]:
#                    combined_metrics.append(x)
                #combined_metrics.append(episode.user_data[metric_key][agent_key])
            #episode.custom_metrics[agent_key] = np.array(combined_metrics,dtype=object)

            episode.custom_metrics[agent_key] = combined_metrics

#        for key, value in episode.user_data['output_states'].items():
#            episode.custom_metrics[key] = value
        #episode.custom_metrics["output_states"] = worker.env.output_states
        #episode.custom_metrics["output_states"] = [5,6]

    def on_sample_end(self, *, worker: RolloutWorker, samples: SampleBatch, **kwargs):
        print("returned sample batch of size {}".format(samples.count))

#    def on_train_result(self, *, algorithm, result: dict, **kwargs):
#        print(
#            "Algorithm.train() result: {} -> {} episodes".format(
#                algorithm, result["episodes_this_iter"]
#            )
#        )
#        # you can mutate the result dict to add new fields to return
#        result["callback_ok"] = True

#    def on_learn_on_batch(
#        self, *, policy: Policy, train_batch: SampleBatch, result: dict, **kwargs
#    ) -> None:
#        result["sum_actions_in_train_batch"] = train_batch["actions"].sum()
#        print(
#            "policy.learn_on_batch() result: {} -> sum actions: {}".format(
#                policy, result["sum_actions_in_train_batch"]
#            )
#        )

#    def on_postprocess_trajectory(
#        self,
#        *,
#        worker: RolloutWorker,
#        episode: Episode,
#        agent_id: str,
#        policy_id: str,
#        policies: Dict[str, Policy],
#        postprocessed_batch: SampleBatch,
#        original_batches: Dict[str, Tuple[Policy, SampleBatch]],
#        **kwargs
#    ):
#        print("postprocessed {} steps".format(postprocessed_batch.count))
#        if "num_batches" not in episode.custom_metrics:
#            episode.custom_metrics["num_batches"] = 0
#        episode.custom_metrics["num_batches"] += 1
