import numpy as np

'''
% Function to compute the classical orbital elements from
% the cartesian position and velocity vectors
%
% Inputs: Oribital_Elements classical orbital elements 6x1
%         mu        Gravitaional parameter
%
% Output: Position  Inertial position vector 3x1
%         Velocity  inertial velocity vector 3x1
%
% Assumptions and Limitations:
%
% Dependencies:
%    ZRot
%    XRot
%
% References:
%    Larson, Wiley J., and James Richard Wertz. Space mission analysis and design. 
%    No. DOE/NE/32145-T1. Torrance, CA (United States); Microcosm, Inc., 1992.
%
%    Wie, Bong. Space vehicle dynamics and control. 
%    American Institute of Aeronautics and Astronautics, 2008.
%
% Author: Andrew Barth
%
% Modification History:
%    May 29 2019 - Initial version
%
'''
def OEToCartesian(t,Orbital_Elements,mu):

#% Create aliases for oribital elements
    a     = Orbital_Elements[0]
    e     = Orbital_Elements[1]
    inc   = Orbital_Elements[2]
    raan  = Orbital_Elements[3]
    omega = Orbital_Elements[4]
    nu    = Orbital_Elements[5]

#% Compute radial position
    p = a*(1-e**2)
    r = p/(1+e*np.cos(nu))

#% Compute position and velocity in perifocal coordinates
    rP = [r*np.cos(nu), r*np.sin(nu), 0]
    vP = [-np.sqrt(mu/p)*np.sin(nu), np.sqrt(mu/p)*(e+np.cos(nu)), 0]

#% Compute transformation from perifocal coordinates to geocentric
#% coordinates
    M_Perifocal_To_ECI = np.transpose(ZRot(omega)*XRot(inc)*ZRot(raan))

#% Rotate the perifocal position and velocity to geocentric coordinates
    Position = np.matmul(M_Perifocal_To_ECI,rP)
    Velocity = np.matmul(M_Perifocal_To_ECI,vP)

    return Position,Velocity


def XRot(angle):
    rotMat = np.array([[1,0,0],[0, np.cos(angle),np.sin(angle)],[0,-np.sin(angle),np.cos(angle)]])
    return rotMat

def ZRot(angle):
    rotMat = np.array([[np.cos(angle),np.sin(angle),0],[-np.sin(angle),np.cos(angle),0],[0,0,1]])
    return rotMat

# This is a port of a Matlab script
