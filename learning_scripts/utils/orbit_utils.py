import os
import numpy as np

# Compute orbit period
def compute_period(a):
    """
    Compute orbit period based on semi-major axis
    Args:
        a: semi-major axis (or radius if circular) km
           must inlcude earth radius
    """

    mu = 398600  # km^3 / s^2
    
    period = 2*np.pi * np.sqrt(a**3 / mu)

    return period

# Compute orbit mean motion
def compute_mean_motion(T):
    """
    Compute orbit mean motion from period
    Args:
        T: orbit period s
    """
    
    omega = 2*np.pi / T

    return omega
