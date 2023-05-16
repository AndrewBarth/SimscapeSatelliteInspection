function [q] = DCMToquat(mat)
% Function to convert a rotation matrix to a quaternion representation
%
% Inputs: mat     rotation matrix 3x3
%
% Output: q       quaternion 4x1
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
%    Jun 11 2019 - Initial version
%

q = zeros(4,1);

q(1) = 0.5*sqrt(mat(1,1) + mat(2,2) + mat(3,3) + 1);
q(2) = (mat(2,3) - mat(3,2)) / (4*q(1));
q(3) = (mat(3,1) - mat(1,3)) / (4*q(1));
q(4) = (mat(1,2) - mat(2,1)) / (4*q(1));

