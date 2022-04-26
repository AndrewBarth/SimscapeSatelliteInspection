function [mat] = quatToDCM(q)
% Function to convert a quaternion to a rotation matrix representation
% ***
% Inputs: q       quaternion 4x1
%
% Output: mat     rotation matrix 3x3
%
% Assumptions and Limitations:
%    scalar is in first element of quaternion
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
%    Jul 03 2019 - Initial version
%

m11 = q(1)^2 + q(2)^2 - q(3)^2 - q(4)^2;
m12 = 2*(q(2)*q(3) + q(1)*q(4));
m13 = 2*(q(2)*q(4) - q(1)*q(3));

m21 = 2*(q(2)*q(3) - q(1)*q(4));
m22 = q(1)^2 - q(2)^2 + q(3)^2 - q(4)^2;
m23 = 2*(q(3)*q(4) + q(1)*q(2));

m31 = 2*(q(2)*q(4) + q(1)*q(3));
m32 = 2*(q(3)*q(4) - q(1)*q(2));
m33 = q(1)^2 - q(2)^2 - q(3)^2 + q(4)^2;

mat = [m11 m12 m13; m21 m22 m23; m31 m32 m33];