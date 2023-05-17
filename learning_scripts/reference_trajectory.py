import numpy as np

class refTraj():
    """
        Compute the reference trajectories for the given time step
    """

    def __init__(self, radius, period):
        self.radius = radius
        self.period = period

    def compute_desired_state(self, time):
        x = self.radius*np.sin(-np.pi/2 - 2*np.pi*time/self.period)
        y = self.radius*np.cos(-np.pi/2 - 2*np.pi*time/self.period)
        z = 0.0

        xdot = -1*self.radius*2*np.pi/self.period*np.cos(-np.pi/2 - 2*np.pi*time/self.period)
        ydot =    self.radius*2*np.pi/self.period*np.sin(-np.pi/2 - 2*np.pi*time/self.period)
        zdot = 0.0
 
        return [x,y,z,xdot,ydot,zdot]



