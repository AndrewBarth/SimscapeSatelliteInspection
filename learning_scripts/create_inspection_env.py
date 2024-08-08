
from ray.tune.registry import register_env
from cubesat_inspection_gym_env import CubesatInspectionEnv


def create_inspection_env(init_type,scenario_type,case_type,nAgents):

    if scenario_type == 'train':
        name = 'Train'
    if scenario_type == 'eval':
        name = 'Eval'

    if init_type == 'fixed':
        if case_type == 'Benchmark1':

            # Benchmark 1
            ref_altitude = 500                # km
            ref_altitude_bounds = [400,1200]  # km
            task_type = {1: 'PRO'}
            caseName = 'Benchmark1_RL_'+name

        elif case_type == 'Benchmark2':
            # Benchmark 2
            ref_altitude = 800                # km
            ref_altitude_bounds = [400,1200]  # km
            task_type = {1: 'PRO', 2: 'PRO', 3: 'PRO', 4: 'PRO'}
            caseName = 'Benchmark2_RL_'+name

            #task_ecc = {1: 0.0, 2: 0.0, 3: 0.5}
            #task_inc = {1: 0, 2: 0, 3: 135}   # DEGREES
            #task_period = {1: 2000, 2: 2000, 3: 0}  # Will be set to period of reference orbit for PRO
            #task_type = {1: 'CIRCLE', 2: 'CIRCLE', 3: 'PRO'}

        elif case_type == 'Benchmark3':
            # Benchmark 3
            ref_altitude = 35000                 # km
            ref_altitude_bounds = [32000,38000]  # km
            task_type = {1: 'PRO'}
            caseName = 'Benchmark3_RL_'+name

        # Set Chief state outside of the the target orbits
        chief_state = [0, -100, 0, 0, 0, 0]

    elif init_type == 'random':
        # For random initialization scenarios only need to specify the number of iterations
        # Initialization parameters will be selected based on the bounds
        ref_altitude_bounds = [400,1200]
        task_type = {1: 'PRO', 2: 'PRO', 3: 'PRO'}
        caseName = 'Varied_RL_'+name+'_LEO'

    # Even when running a fixed state scenario, the bounds are used for observation
    # normalization. 
    task_semimajor_bounds = {1: [5, 50], 2: [5, 50], 3: [5, 50], 4: [5,50]}
    task_ecc_bounds = {1: [0.4999, 0.5001], 2: [0.4999, 0.5001], 3: [0.4999, 0.5001], 4: [0.4999, 0.5001]}    # ECC must be less than 1.0
    task_inclination_bounds = {1: [0, 80], 2: [0, 80], 3: [0, 80], 4: [0,80]}
    task_period_bounds = {1: [10*60, 60*60], 2: [10*60, 60*60], 3: [10*60, 60*60], 4: [10*60, 60*60]}
    chief_bounds = [0,100]   # Chief will be initialized outside the largest task trajectory, 
                             # therefore lower bound may be overwritten


    # Register enviornment with gym and create an instance of the environment
    if init_type == 'fixed':
        register_env(
            "multi_agent_sat_servicing", lambda _: CubesatInspectionEnv(nAgents=nAgents,altitude=ref_altitude,chief_state=chief_state,task_type=task_type,chief_bounds=chief_bounds,semimajor_bounds=task_semimajor_bounds,eccentricity_bounds=task_ecc_bounds,altitude_bounds=ref_altitude_bounds,inclination_bounds=task_inclination_bounds,task_period_bounds=task_period_bounds,scenario_type=scenario_type,init_type=init_type)
        )

        env = CubesatInspectionEnv(nAgents=nAgents,altitude=ref_altitude,chief_state=chief_state,task_type=task_type,chief_bounds=chief_bounds,semimajor_bounds=task_semimajor_bounds,eccentricity_bounds=task_ecc_bounds,altitude_bounds=ref_altitude_bounds,inclination_bounds=task_inclination_bounds,task_period_bounds=task_period_bounds,scenario_type=scenario_type,init_type=init_type)
    elif init_type == 'random':

        register_env(
            "multi_agent_sat_servicing", lambda _: CubesatInspectionEnv(nAgents=nAgents,chief_bounds=chief_bounds,task_type=task_type,semimajor_bounds=task_semimajor_bounds,eccentricity_bounds=task_ecc_bounds,altitude_bounds=ref_altitude_bounds,inclination_bounds=task_inclination_bounds,task_period_bounds=task_period_bounds,scenario_type=scenario_type,init_type=init_type)
        )

        env = CubesatInspectionEnv(nAgents=nAgents,chief_bounds=chief_bounds,task_type=task_type,semimajor_bounds=task_semimajor_bounds,eccentricity_bounds=task_ecc_bounds,altitude_bounds=ref_altitude_bounds,inclination_bounds=task_inclination_bounds,task_period_bounds=task_period_bounds,scenario_type=scenario_type,init_type=init_type)

    return env,task_type,caseName

