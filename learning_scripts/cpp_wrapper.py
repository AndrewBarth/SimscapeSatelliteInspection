import ctypes
from ctypes import cdll
import numpy as np
lib = cdll.LoadLibrary('../SatelliteServicing_Mission.so')

class cppWrapper(object):
    def __init__(self):
        pass

    def init_cpp(self, agent_ids, initial_state_dict):
        print('Initializing CPP Simulation')

        nAgents = len(agent_ids)

        # Extract the initial conditions from the dictionary
        initial_states = []
        for agent_id in agent_ids:
            initial_states.extend(initial_state_dict[agent_id][0:6])

        # Create variables using ctypes to pass initial conditions to C++
        lib._Z8sim_initPd.argtypes = [ctypes.POINTER(ctypes.c_double)]
        initial_state_data = (ctypes.c_double * (6*nAgents) )(*initial_states)

        ret = lib._Z8sim_initPd(initial_state_data)

    def step_cpp(self,agent_ids,action_dict,stop_time):

        nAgents = len(agent_ids)
        nDof = 3;

        # Extract the actions from the dictionary
        actions = []
        for agent_id in agent_ids:
            actions.extend(action_dict[agent_id][0:nDof])

        # Create variables using ctypes to pass actions and 
        # observations to and from C++
        # NOTE: Sizes are hardcoded in the C++ code so nAgents must match
        # the value used to generate the C++ code
        lib._Z11sim_wrapperdPdS_PiS_.argtypes = [ctypes.c_double, ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_int),ctypes.POINTER(ctypes.c_double)]
        empty_var = []
        action_data = (ctypes.c_double * (nDof*nAgents) )(*actions)
        observation_data = (ctypes.c_double  * (50*nAgents) )(*empty_var)
        done_data = (ctypes.c_int  * 2)(*empty_var)
        stoptime_data = (ctypes.c_double)(stop_time)
        simtime = (ctypes.c_double * 1)(*empty_var)
       
        # Call the CPP program
        ret = lib._Z11sim_wrapperdPdS_PiS_(stoptime_data,action_data,observation_data,done_data,simtime)

        # Extract the observations and place them in a python dictionary
        observations = {}
        for agent_id in agent_ids:
            observations[agent_id] = [observation_data[50*(agent_id-1)+i] for i in range(50)]

        # Extract the dones and place them in a python dictionsary
        # Dones are shared between all agents
        dones = {}
        for agent_id in agent_ids:
            dones[agent_id] = any([bool(done_data[i]) for i in range(2)])

        return observations, dones, simtime[0]
    
