function [Euler] = robotDCMToEuler_321(DCM) 
% Function to convert a direction cosine matrix to a set of Euler angles
%
% Inputs: DCM     direction cosine matrix 3x3
%
% Output: Euler   Euler angles 3x1
%
% Assumptions and Limitations:
%    Euler angles expressed in radians
%    3-2-1 Euler rotation sequence
%    Uses robotic convention for rotations
%
% Dependencies:
%
% References:
%    Kuipers, Jack B. Quaternions and rotation sequences. Vol. 66. 
%    Princeton: Princeton university press, 1999.
%
% Author: Andrew Barth
%
% Modification History:
%    Mar 31 2022 - Initial version
%

Euler = zeros(3,1);
Euler(3) = atan2(-DCM(1,2),DCM(1,1));
Euler(2) = atan2(DCM(1,3),sqrt(DCM(1,1)^2 + DCM(1,2)^2));
Euler(1) = atan2(-DCM(2,3),DCM(3,3));
    
