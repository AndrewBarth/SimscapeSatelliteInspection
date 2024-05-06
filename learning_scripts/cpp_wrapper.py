import ctypes
from ctypes import cdll
import numpy as np
lib = cdll.LoadLibrary('../SatelliteServicing_Mission.so')

class cppWrapper(object):
    def __init__(self):
        pass

    def init_cpp(self, agent_ids, initial_state_dict, dof_dict):
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
        lib._Z8sim_initPdS_Pi.argtypes = [ctypes.POINTER(ctypes.c_double),ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_int)]
        empty_var = []
        initial_state_data = (ctypes.c_double * (nStates) )(*initial_states)
        joint_limit_data = (ctypes.c_double * (2*nJoints))(*empty_var)
        nFaces_data = (ctypes.c_int * 1)(*empty_var)

        ret = lib._Z8sim_initPdS_Pi(initial_state_data,joint_limit_data,nFaces_data)

        # Extract the joint limits and place them in a python dictionsary
        joint_limit_dict = {}
        for agent_id in agent_ids:
            joint_limit_dict[agent_id] = [joint_limit_data[i] for i in range(2*dof_dict[agent_id])]


        return joint_limit_dict, nFaces_data[0]

    def step_cpp(self,agent_ids,action_dict,stop_time,control_step_size,nFaces):

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
        lib._Z11sim_wrapperddPdS_S_PiS0_S_i.argtypes = [ctypes.c_double, ctypes.c_double, ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),ctypes.POINTER(ctypes.c_double),ctypes.c_int]
        empty_var = []
        action_data = (ctypes.c_double * (nActions) )(*actions)
        observation_data = (ctypes.c_double  * (nObservations) )(*empty_var)
        error_data = (ctypes.c_double  * (nErrors) )(*empty_var)
        coverage_data = (ctypes.c_int * (nFaces)) (*empty_var)
        done_data = (ctypes.c_int  * 2)(*empty_var)
        stoptime_data = (ctypes.c_double)(stop_time)
        controlStepSize_data = (ctypes.c_double)(control_step_size)
        simtime = (ctypes.c_double * 1)(*empty_var)
        nFaces_data = (ctypes.c_int)(nFaces)
       
        # Call the CPP program
        ret = lib._Z11sim_wrapperddPdS_S_PiS0_S_i(stoptime_data,controlStepSize_data,action_data,observation_data,error_data,coverage_data,done_data,simtime,nFaces_data)

        # Extract the observations and place them in a python dictionary
        observations = {}
        errors = {}
        coverage = {}
        for agent_id in agent_ids:
            observations[agent_id] = [observation_data[i] for i in range(34)]
            errors[agent_id] = [error_data[i] for i in range(13)]
            coverage[agent_id] = [coverage_data[i] for i in range(nFaces)]

        # Extract the dones and place them in a python dictionsary
        # Dones are shared between all agents
        dones = {}
        for agent_id in agent_ids:
            dones[agent_id] = any([bool(done_data[i]) for i in range(2)])

        return observations, errors, coverage, dones, simtime[0]
    
