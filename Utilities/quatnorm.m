function [qout] = quatnorm(qin)
% Function to normalize a quaternion
%
% Inputs: qin       input quaternion 4x1
%
% Output: qout      output quaternion 4x1
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
%    Jun 30 2019 - Initial version
%

qnorm = sqrt(qin(1)^2 + qin(2)^2 + qin(3)^2 + qin(4)^2);

qout = qin/qnorm;