import numpy as np
from utils import kepler

class taskTraj():
    """
        Compute the task trajectories for the given time step
    """

    def __init__(self, semi_major_axis, eccentricity, inclination, period, orbit_type):

        self.earth_radius = 6378.0   # km
        self.earth_mu = 398600 # km^3/s^2

        self.period = period
        self.omega = 2*np.pi/self.period
        self.mean_motion = 2*np.pi/self.period

        self.semi_major_axis = semi_major_axis
        self.semi_minor_axis = semi_major_axis*np.sqrt(1-eccentricity**2)self.semi_major_axis
        self.orbit_type = orbit_type;

        self.inclination_rad = inclination*np.pi/180.0

        if self.orbit_type == 'PRO':
            self.y0 = -1*self.semi_major_axis
            self.zdot0 = np.tan(self.inclination_rad)*0.5*self.y0*self.mean_motion
            self.initial_state = [0, self.y0, 0, 0.5*self.y0*self.mean_motion, 0, np.tan(self.inclination_rad)*0.5*self.y0*self.mean_motion]

            self.major_vec = np.array([0, self.y0, 0])
            self.minor_vec = np.array([self.y0/2*np.cos(self.inclination_rad), 0, self.y0/2*np.sin(self.inclination_rad)])
        elif self.orbit_type == 'CIRCLE':
            self.radius = self.semi_major_axis
            if self.period > 1e-3:
                speed = 2*np.pi*self.radius / self.period
            else:
                speed = 0
            self.initial_state = [0, self.radius, 0, speed*np.cos(self.inclination_rad), 0.0, speed*np.sin(self.inclination_rad)]

            self.major_vec = np.array([0, self.radius, 0])
            self.minor_vec = np.array([self.radius*np.cos(self.inclination_rad), 0, self.radius*np.sin(self.inclination_rad)])

        # Define orbit normal and origin
        orbit_normal = np.cross(self.major_vec,self.minor_vec)
        self.orbit_normal = orbit_normal/np.linalg.norm(orbit_normal)
        self.orbit_origin = np.array([0,0,0])

        self.x0 = self.initial_state[0]
        self.y0 = self.initial_state[1]
        self.z0 = self.initial_state[2]
        self.xdot0 = self.initial_state[3]
        self.ydot0 = self.initial_state[4]
        self.zdot0 = self.initial_state[5]


    def evaluate_pro(self,time):
        # Compute the position and velocity in the PRO for the given time 
        # Units are assumed to be meters, though equations are general

        wt = self.omega*time
        cwt = np.cos(wt)
        swt = np.sin(wt)

        x = self.y0/2*swt
        y = self.y0*cwt + self.y0 - 2*self.xdot0/self.omega
        z = self.zdot0/self.omega*swt

        xdot = self.y0/2*self.omega*cwt
        ydot = -1*self.y0*self.omega*swt
        zdot = self.zdot0*cwt

        return [x,y,z,xdot,ydot,zdot]

    def evaluate_circular(self, time):
        # Compute the position and velocity in the co-planar circular orbit for the given time 
        # Units are assumed to be meters, though equations are general
        #x = self.radius*np.sin(-np.pi/2 - 2*np.pi*time/self.period)
        #y = self.radius*np.cos(-np.pi/2 - 2*np.pi*time/self.period)
        #z = 0.0

        #xdot = -1*self.radius*2*np.pi/self.period*np.cos(-np.pi/2 - 2*np.pi*time/self.period)
        #ydot =    self.radius*2*np.pi/self.period*np.sin(-np.pi/2 - 2*np.pi*time/self.period)
        #zdot = 0.0
 
        x = self.radius*np.sin(2*np.pi*time/self.period)
        y = self.radius*np.cos(2*np.pi*time/self.period)
        z = 0.0

        xdot = -1*self.radius*2*np.pi/self.period*np.cos(2*np.pi*time/self.period)
        ydot =    self.radius*2*np.pi/self.period*np.sin(2*np.pi*time/self.period)
        zdot = 0.0
        return [x,y,z,xdot,ydot,zdot]

    def evaluate_orbit(self, time):

        if self.orbit_type == 'PRO':
           [x,y,z,xdot,ydot,zdot] = self.evaluate_pro(time)
        elif self.orbit_type == 'CIRCLE':
           [x,y,z,xdot,ydot,zdot] = self.evaluate_circular(time)
        else:
            # Solve Kepler's problem to propagate state to the desired time
            # TO USE PROPERLY, INPUT R,V MUST BE RELATIVE TO EARTH ORIGIN
            r,v = kepler.kepler([self.x0/1000,self.y0/1000,self.z0/1000],[self.xdot0/1000,self.ydot0/1000,self.zdot0/1000],time)
            [x,y,z,xdot,ydot,zdot] = np.concatenate((r*1000,v*1000)).tolist()

        return x,y,z,xdot,ydot,zdot

    def closest_point_on_orbit(self,point):
        # Compute the closest point on the reference PRO to the input point
        # Units are assumed to be meters, though equations are general

        # Compute distance from desired point to a point on the plane
        dp = point - self.orbit_origin

        # Determine the perpendicular distance from the point to the plane along the orbit normal
        dist = np.dot(self.orbit_normal,dp)

        # Move the point onto the plane by subtracting the perpendicular distance along 
        # the normal direction
        pprime = point - dist*self.orbit_normal

        # Determine the angle between the reference point on the orbit with the projected point
        
        # first normalize the vectors
        refVec = np.array([self.x0,self.y0,self.z0])
        uRef = refVec/np.linalg.norm(refVec)
        if np.linalg.norm(pprime) < 1e-6:
            uPPrime = np.array([1,0,0])
        else:
            uPPrime = pprime/np.linalg.norm(pprime)
        angle = np.arccos(np.dot(uPPrime,uRef))

        # Quadrant check for angle
        check = np.cross(uPPrime,uRef) 
        if check[2] < 0:
            angle = 2*np.pi - angle

        # Find the point on the orbit corresponding to this angle
        # This is the closest point to the test point
        closest_point = self.evaluate_orbit(angle/self.omega)

        return closest_point, angle


