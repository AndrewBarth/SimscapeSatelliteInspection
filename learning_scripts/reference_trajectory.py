import numpy as np
from scipy import interpolate

class refTraj():
    """
        Compute the reference trajectories for the given time step
    """

    def __init__(self, stop_time):
        dtr = np.pi/180.0

        # Set the end effector reference trajectory
        self.eeRefTraj = np.array([[0.0,  -0.2,   -0.0,  0.2710,  90.0*dtr,  0.0,   -80.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [20.0, -0.25,   0.3,  0.2710,  90.0*dtr,  0.0,  -150.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [30.0,  0.0,    0.4,  0.2710,  90.0*dtr,  0.0,  -150.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [50.0,  0.0,    0.4,  0.2710,  45.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [70.0,  0.4,    0.6,  0.2710,  45.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                              [stop_time,  0.4,    0.6,  0.2710,  45.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0]])

        # Define an interpolation function for the table
        self.interpFunc = interpolate.interp1d(self.eeRefTraj[:,0],self.eeRefTraj[:,1:13],axis=0,assume_sorted=True)

    def compute_desired_state(self, time):

        # Call the interpolation and compute the desired values at the current time
        desired_values = self.interpFunc(time)
 
        return desired_values



