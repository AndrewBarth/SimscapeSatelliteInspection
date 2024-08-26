import ctypes
from ctypes import cdll
import numpy as np
lib = cdll.LoadLibrary('../SatelliteServicing_Mission.so')

class cppWrapper(object):
    def __init__(self):
        pass

    def init_cpp_robotics(self, agent_ids, initial_state_dict, dof_dict, sim_step_size):
        print('Initializing CPP Simulation')

        nAgents = len(agent_ids)

        # Extract the initial conditions from the dictionary
        initial_states = []
        nStates = 0
        nJoints = 0
        for agent_id in agent_ids:
            nJoints += dof_dict[agent_id]
            nStates += len(initial_state_dict[agent_id])
            initial_states.extend(initial_state_dict[agent_id])

        nStates = len(initial_states)
        # Create variables using ctypes to pass initial conditions to C++
        lib.sim_init.argtypes = [ctypes.c_double, ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_double)]
        empty_var = []
        sim_step_size_data = (ctypes.c_double)(sim_step_size)
        initial_state_data = (ctypes.c_double * (nStates) )(*initial_states)
        joint_limit_data = (ctypes.c_double * (2*nJoints))(*empty_var)

        ret = lib.sim_init(sim_step_size_data,initial_state_data,joint_limit_data)

        # Extract the joint limits and place them in a python dictionsary
        joint_limit_dict = {}
        for agent_id in agent_ids:
            joint_limit_dict[agent_id] = [joint_limit_data[i] for i in range(2*dof_dict[agent_id])]


        return joint_limit_dict

    def step_cpp_robotics(self,agent_ids,action_dict,stop_time,control_step_size):

        nAgents = len(agent_ids)

        # Extract the actions from the dictionary
        actions = []
        for agent_id in agent_ids:
            actions.extend(action_dict[agent_id])

        nActions = len(actions)
        nObservations = 34*nAgents
        nErrors = 13*nAgents
        # Create variables using ctypes to pass actions and 
        # observations to and from C++
        # NOTE: Sizes are hardcoded in the C++ code so nAgents must match
        # the value used to generate the C++ code
        lib.sim_wrapper.argtypes = [ctypes.c_double, ctypes.c_double, ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_int),ctypes.POINTER(ctypes.c_double)]
        empty_var = []
        action_data = (ctypes.c_double * (nActions) )(*actions)
        observation_data = (ctypes.c_double  * (nObservations) )(*empty_var)
        error_data = (ctypes.c_double  * (nErrors) )(*empty_var)
        done_data = (ctypes.c_int  * 2)(*empty_var)
        stoptime_data = (ctypes.c_double)(stop_time)
        controlStepSize_data = (ctypes.c_double)(control_step_size)
        simtime = (ctypes.c_double * 1)(*empty_var)
       
        # Call the CPP program
        ret = lib.sim_wrapper(stoptime_data,controlStepSize_data,action_data,observation_data,error_data,done_data,simtime)

        # Extract the observations and place them in a python dictionary
        observations = {}
        errors = {}
        for agent_id in agent_ids:
            observations[agent_id] = [observation_data[i] for i in range(34)]
            errors[agent_id] = [error_data[i] for i in range(13)]

        # Extract the dones and place them in a python dictionsary
        # Dones are shared between all agents
        dones = {}
        for agent_id in agent_ids:
            dones[agent_id] = any([bool(done_data[i]) for i in range(2)])

        return observations, errors, dones, simtime[0]
    
    def init_cpp_inspection(self, sim_step_size, agent_ids, fov, mean_motion, initial_state_dict):
        print('Initializing CPP Simulation')

        nAgents = len(agent_ids)

        # Extract the initial conditions from the dictionary
        initial_states = []
        nStates = 0
        nJoints = 0
        for agent_id in agent_ids:
            initial_states.extend(initial_state_dict[agent_id])

        nStates = len(initial_states)
        # Create variables using ctypes to pass initial conditions to C++
        lib.sim_init.argtypes = [ctypes.c_double, ctypes.c_int, ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_double), ctypes.c_double, ctypes.POINTER(ctypes.c_int)]
        empty_var = []
        sim_step_size_data = (ctypes.c_double)(sim_step_size)
        nAgent_data = (ctypes.c_int)(nAgents)
        fov_data = (ctypes.c_double * (nAgents) )(*fov)
        initial_state_data = (ctypes.c_double * (nStates) )(*initial_states)
        mean_motion_data = (ctypes.c_double)(mean_motion)
        nFaces_data = (ctypes.c_int * 1)(*empty_var)

        ret = lib.sim_init(sim_step_size_data,nAgent_data,fov_data,initial_state_data,mean_motion_data,nFaces_data)

        return nFaces_data[0]

    def step_cpp_inspection(self,agent_ids,nFaces,stop_time,control_step_size,action_dict):

        nAgents = len(agent_ids)

        # Extract the actions from the dictionary
        actions = []
        for agent_id in agent_ids:
            actions.extend(action_dict[agent_id])

        nActions = len(actions)
        nObservations = 34*nAgents
        nErrors = 13*nAgents
        # Create variables using ctypes to pass actions and 
        # observations to and from C++
        # NOTE: Sizes are hardcoded in the C++ code so nAgents must match
        # the value used to generate the C++ code
        lib.sim_wrapper.argtypes = [ctypes.c_int, ctypes.c_int, ctypes.c_double, ctypes.c_double, ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_double)]
        empty_var = []
        nAgent_data = (ctypes.c_int)(nAgents)
        nFaces_data = (ctypes.c_int)(nFaces)
        stoptime_data = (ctypes.c_double)(stop_time)
        controlStepSize_data = (ctypes.c_double)(control_step_size)
        action_data = (ctypes.c_double * (nActions) )(*actions)
        state_data = (ctypes.c_double  * (9*4) )(*empty_var)
        coverage_data = (ctypes.c_int  * (nFaces) )(*empty_var)
        done_data = (ctypes.c_int  * 2)(*empty_var)
        simtime = (ctypes.c_double * 1)(*empty_var)
       
        # Call the CPP program
        #ret = lib._Z11sim_wrapperiiddPdPiS0_S_(nAgent_data,nFaces_data,stoptime_data,controlStepSize_data,action_data,state_data,coverage_data,done_data,simtime)
#        ret = lib._Z11sim_wrapperiiddPdPiS0_S_(nAgent_data,nFaces_data,stoptime_data,controlStepSize_data,action_data,coverage_data,done_data,simtime)
        ret = lib.sim_wrapper(nAgent_data,nFaces_data,stoptime_data,controlStepSize_data,action_data,state_data,coverage_data,done_data,simtime)

        # Extract the observations and place them in a python dictionary
        states = {}
        coverage = {}
        for agent_id in agent_ids:
            states[agent_id] = [state_data[9*(agent_id-1)+i] for i in range(9)]
            coverage[agent_id] = [coverage_data[i] for i in range(nFaces)]

        # Extract the dones and place them in a python dictionsary
        # Dones are shared between all agents
        dones = {}
        for agent_id in agent_ids:
#            dones[agent_id] = any([bool(done_data[i]) for i in range(2)])
            dones[agent_id] = done_data


        #return states, coverage, dones, simtime[0]
        return states, coverage, dones, simtime[0]
