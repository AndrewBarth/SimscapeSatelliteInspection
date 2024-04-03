import numpy as np
from scipy import interpolate

class refTraj():
    """
        Compute the reference trajectories for the given time step
    """

    def __init__(self, stop_time):
        dtr = np.pi/180.0

        # Set the end effector reference trajectory
        if stop_time < 80.0:
            last_point = 80.0
        else:
            last_point = stop_time

        #self.eeRefTraj = np.array([[0.0,  -0.2,   -0.0,  0.2710,  90.0*dtr,  0.0,   -80.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
        #                           [20.0, -0.25,   0.3,  0.2710,  90.0*dtr,  0.0,  -150.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
        #                           [30.0,  0.0,    0.4,  0.2710,  90.0*dtr,  0.0,  -150.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
        #                           [50.0,  0.0,    0.4,  0.2710,  45.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
        #                           [70.0,  0.4,    0.6,  0.2710,  45.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
        #                     [last_point,  0.4,    0.6,  0.2710,  45.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0]])
        #self.eeRefTraj = np.array([[0.0,  -0.2,   -0.0,  0.2710,  90.0*dtr,  0.0,   -70.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
        #                           [20.0, -0.25,   0.3,  0.2710,  90.0*dtr,  0.0,  -150.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
        #                           [30.0,  0.0,    0.4,  0.2710,  90.0*dtr,  0.0,  -150.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
        #                           [50.0,  0.0,    0.4,  0.2710,  90.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
        #                           [70.0,  0.4,    0.6,  0.2710,  90.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
        #                     [last_point,  0.4,    0.6,  0.2710,  90.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0]])
        self.eeRefTraj = np.array([[0.0,  -0.235,  -0.0,  0.2710,  90.0*dtr,  0.0,   -70.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [20.0, -0.235,  -0.0,  0.2710,  90.0*dtr,  0.0,  -150.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [30.0,  0.0,    0.4,  0.2710,  90.0*dtr,  0.0,  -150.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [50.0,  0.0,    0.4,  0.2710,  90.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [70.0,  0.4,    0.6,  0.2710,  90.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                             [last_point,  0.4,    0.6,  0.2710,  90.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0]])
        self.eeRefTraj = np.array([[0.0,  -0.4,    0.2,  0.2710,  90.0*dtr,  0.0,  -120.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [50.0, -0.235,  -0.0,  0.2710,  90.0*dtr,  0.0,  -150.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [60.0,  0.0,    0.4,  0.2710,  90.0*dtr,  0.0,  -150.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [70.0,  0.0,    0.4,  0.2710,  90.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [80.0,  0.4,    0.6,  0.2710,  90.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                             [last_point,  0.4,    0.6,  0.2710,  90.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0]])
        self.eeRefTraj = np.array([[0.0,  -0.2362, 0.0438, 0.2710,  90.0*dtr,  0.0,  -80*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [50.0, -0.4280, 0.1395, 0.2710,  90.0*dtr,  0.0,  -125*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [60.0, -0.235,  -0.0,  0.2710,  90.0*dtr,  0.0,  -150.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [70.0,  0.0,    0.4,  0.2710,  90.0*dtr,  0.0,  -150.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                                   [80.0,  0.0,    0.4,  0.2710,  90.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0],
                             [last_point,  0.4,    0.6,  0.2710,  90.0*dtr,  0.0,    90.0*dtr,  0.0,  0.0, 0.0, 0.0, 0.0, 0.0]])

        # Define an interpolation function for the table
        self.interpFunc = interpolate.interp1d(self.eeRefTraj[:,0],self.eeRefTraj[:,1:13],axis=0,assume_sorted=True)

    def compute_desired_state(self, time):

        # Call the interpolation and compute the desired values at the current time
        #desired_values = self.interpFunc(time)

        npts = self.eeRefTraj.shape[0]
        for i in reversed(range(npts)):
            if time >= self.eeRefTraj[i][0]:
                desired_values = self.eeRefTraj[i][1:13]

                if i == npts: 
                    # hold last point
                    wpt_f = self.eeRefTraj[i][0:13]
                    wpt_i = wpt_f
                else: 
                    wpt_f = self.eeRefTraj[i+1][0:13]
                    wpt_i = self.eeRefTraj[i][0:13]

        # Compute cubic polynomial
        new_des_state=np.zeros(12)
        linear_cubic_coeffs = np.zeros((4,3))
        angular_cubic_coeffs = np.zeros((4,3))
        for k in range(3):
            linear_cubic_coeffs[:,k] = cubic_polynomial(wpt_i[0],wpt_f[0],wpt_i[1+k],wpt_f[1+k],wpt_i[7+k],wpt_f[7+k])
            angular_cubic_coeffs[:,k] = cubic_polynomial(wpt_i[0],wpt_f[0],wpt_i[4+k],wpt_f[4+k],wpt_i[10+k],wpt_f[10+k])
       
            [lq, lv, la] = compute_state_cubic(linear_cubic_coeffs[:,k],time)
            new_des_state[0+k] = lq
            new_des_state[6+k] = lv
            [aq, av, aa] = compute_state_cubic(angular_cubic_coeffs[:,k],time)
            new_des_state[3+k] = aq
            new_des_state[9+k] = av
             
        return new_des_state
        #return desired_values


def cubic_polynomial(t0,tf,q0,qf,v0,vf):
    '''
    Function to compute the coefficients for a cubic polynomal with
    position and velocity constraints
    Inputs: t0, tf - Initial time, final time
            q0, qf - Initial position, final position
            v0, vf - Initial velocity, final velocity
    Outputs: a - polynomial coefficiens (size 4)
    '''         
    # Form cubic polynomial matrix
    M = np.array([[1, t0, t0**2, t0**3], 
                  [0, 1, 2*t0, 3*t0**2],
                  [1, tf, tf**2, tf**3],
                  [0, 1, 2*tf, 3*tf**2]])

    # Form state vector
    v = np.array([q0, v0, qf, vf])

    # Compute polynomial coefficients
    a = np.dot(np.linalg.pinv(M), v)
    
    return a

def compute_state_cubic(a,t):
    '''
    Function to compute the object state (position, 
    velocity, acceleration) at a given time based
    on a cubic polynomial trajectory.
    Inputs: a  - Coefficients of cubic polynomial (size 4)
            t  - Current time
    Outputs: q     - Position
             v     - Velocity
             alpha - Acceleration
    ''' 
    q = a[0] + a[1]*t + a[2]*t**2 + a[3]*t**3
    v = a[1] + 2*a[2]*t + 3*a[3]*t**2
    alpha = 2*a[2] + 6*a[3]*t

    return q, v, alpha

