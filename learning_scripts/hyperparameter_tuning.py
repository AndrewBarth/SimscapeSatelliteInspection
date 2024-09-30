import sys
import os
import time
import numpy as np
from ray.train import RunConfig, CheckpointConfig
from ray import air, tune
from ray.tune.schedulers import PopulationBasedTraining


def HyperparameterTuning(algoConfig):
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
    stopping_criteria = {"training_iteration": 50, "episode_reward_mean": 100.0}

    # Episodes for evalutaion
    duration = 1


    # Set up the tune parameters
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

    print('Tuning Complete')
