function [DCM] = robotEulerToDCM_321(Euler) 
% Function to convert a set of Euler angles to a direction cosine matrix
%
% Inputs: Euler   Euler angles 3x1
%
% Output: DCM     direction cosine matrix 3x3
%
% Assumptions and Limitations:
%    Euler angles expressed in radians
%    3-2-1 Euler rotation sequence
%    Uses robotic convention for rotations
%
% Dependencies:
%    robotXRot
%    robotYRot
%    robotZRot
%
% References:
%    Kuipers, Jack B. Quaternions and rotation sequences. Vol. 66. 
%    Princeton: Princeton university press, 1999.
%
% Author: Andrew Barth
%
% Modification History:
%    Jun 11 2019 - Initial version
%

DCM = robotXRot(Euler(1))*robotYRot(Euler(2))*robotZRot(Euler(3));
