function [q] = EulerToquat_321(euler)
% Function to convert a set of Euler angles to a quaternion representation
%
% Inputs: euler   Euler angles 3x1
%
% Output: q       quaternion 4x1
%
% Assumptions and Limitations:
%    Euler angles expressed in radians
%    3-2-1 Euler rotation sequence
%    scalar is in first element of quaternion
%
% Dependencies:
%    quatmult
%
% References:
%    Kuipers, Jack B. Quaternions and rotation sequences. Vol. 66. 
%    Princeton: Princeton university press, 1999.
%
%    Wie, Bong. Space vehicle dynamics and control. 
%    American Institute of Aeronautics and Astronautics, 2008.
%
% Author: Andrew Barth
%
% Modification History:
%    May 15 2019 - Initial version
%    Sep 23 2022 - Default sizing added for Simulink
%
q = zeros(4,1);

% Compute component quaternions
q3 = [cos(euler(3)/2) 0 0 sin(euler(3)/2)];
q2 = [cos(euler(2)/2) 0 sin(euler(2)/2) 0];
q1 = [cos(euler(1)/2) sin(euler(1)/2) 0 0];

% Compute output q = q3*q2*q1
q21  = quatmult(q2,q1);
q321 = quatmult(q3,q21);
q = q321';
