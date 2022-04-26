function [qout] = quatconj(qin)
% Function to form the conjucate of a quaternion
%
% Inputs: qin     input quaternion 4x1
% 
% Output: qout    output quaternion 4x1
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
%    May 16 2019 - Initial version
%

qout = [qin(1) -1*qin(2:4)];