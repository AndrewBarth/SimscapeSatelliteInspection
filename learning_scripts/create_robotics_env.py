
from ray.tune.registry import register_env
from sat_servicing_gym_env import SatServiceEnv


def create_robotics_env(scenario_type,nAgents):

    if scenario_type == 'train':
        name = 'Train'
    if scenario_type == 'eval':
        name = 'Eval'


    caseName = 'Single_Arm_Robotics'+name

    # Set initial conditions
    initial_state = {}
    # The initial joint angles of each agent
    initial_state[1] = [80,90,20]

    stop_time = 50.0

    # Set time steps for the dynamics simulation and learning algorithm
    sim_step_size = 0.001     # Needs to be the same as the cpp step size until I figure out how to change it
    control_step_size = 0.1


    # Degrees of freedom for each agent
    dof = {1: 3}

    # Register enviornment with gym and create an instance of the environment
    register_env(
        "multi_agent_sat_servicing", lambda _: SatServiceEnv(initial_state=initial_state,dof=dof,stop_time=stop_time,sim_step_size=sim_step_size,control_step_size=control_step_size,nAgents=nAgents)
    )

    env = SatServiceEnv(initial_state=initial_state,dof=dof,stop_time=stop_time,sim_step_size=sim_step_size,control_step_size=control_step_size,nAgents=nAgents)



    return env,caseName

