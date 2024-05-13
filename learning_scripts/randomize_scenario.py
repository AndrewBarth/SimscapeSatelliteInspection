import numpy as np
from utils import orbit_utils

class randomState():
    """
        Compute the reference trajectories for the given time step
    """

    def __init__(self):

        self.earth_radius = 6378   #km

        self.rng = np.random.default_rng()

    def select_ref_orbit(self, ref_altitude_bounds):

        # Select the value for the primary orbit altitude 
        altitude = self.rng.uniform(ref_altitude_bounds[0],ref_altitude_bounds[1])

        #  Compute period and mean motion
        period = orbit_utils.compute_period(altitude+self.earth_radius)
        mean_motion = orbit_utils.compute_mean_motion(period)

        return altitude,period,mean_motion


    def select_semimajor(self, task_semimajor_bounds):

        # Select semi major axis value for the task trajectory
        semimajor = self.rng.uniform(task_semimajor_bounds[0],task_semimajor_bounds[1])

        return semimajor

    def select_eccentricity(self, task_eccentricity_bounds):

        # Select eccentricity value for the task trajectory
        eccentricity = self.rng.uniform(task_eccentricity_bounds[0],task_semimajor_bounds[1])

        return eccentricity

    def select_inclination(self, task_inclination_bounds):

        # Select inclination value for the task trajectory
        inclination = self.rng.uniform(task_inclination_bounds[0],task_inclination_bounds[1])
        
        # a 90 deg inclination is not a valid PRO
        nChoices = 1
        while inclination > 75.0 and inclination < 105.0:
            inclination = self.rng.uniform(task_inclination_bounds[0],task_inclination_bounds[1])
            nChoices += 1
            if nChoices > 100:
                 inclination = 0.0
                 print("Having trouble finding a valid inclination")
                 break

        return inclination

    def select_period(self, task_period_bounds):

        # Select period value for the task trajectory
        period = self.rng.uniform(task_period_bounds[0],task_period_bounds[1])

        return period

    def select_chief_state(self, ref_semimajor, chief_bounds):

        # Do not initialize chief inside the reference trajectory
        # with a 20% buffer
        if chief_bounds[0] < np.abs(1.2*ref_semimajor):
            major_axis_lower_bound = 1.2*ref_semimajor
        else:
            major_axis_lower_bound = chief_bounds[0]
        minor_axis_lower_bound = chief_bounds[0]
        out_of_plane_lower_bound = chief_bounds[0]
        upper_bound = chief_bounds[1]

        # Choose an initial vector for the initial state
        signs = self.rng.choice([-1,1],size=3)
        state=np.empty(6)
        state[0] = signs[0]*self.rng.uniform(minor_axis_lower_bound,upper_bound)
        state[1] = signs[1]*self.rng.uniform(major_axis_lower_bound,upper_bound)
        state[2] = signs[2]*self.rng.uniform(out_of_plane_lower_bound,upper_bound)
        # Currently only the y component is being perturbed
        state[0] = 0.0
        #state[1] = -100.0
        state[2] = 0.0
        state[3] = 0.0
        state[4] = 0.0
        state[5] = 0.0

        # Check if upper bound is violated and scale if necessary
        if np.linalg.norm(state) > upper_bound:
            scale = upper_bound / np.linalg.norm(state)
            state = state * scale

        return np.array(state)

