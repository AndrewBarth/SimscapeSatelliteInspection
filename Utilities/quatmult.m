function [q] = quatmult(q1,q2)
% Function to multiply two quaternions
%
% Inputs: q1      first input quaternion 1x4
%         q2      second input quaternion 1x4
% 
% Output: q       output quaternion 1/4
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

% Form alias
q1s = q1(1);
q1v = q1(2:4);
q2s = q2(1);
q2v = q2(2:4);

% Compute multiplication
qs = q1s*q2s -dot(q1v,q2v);
qv = q1s*q2v + q2s*q1v + cross(q1v,q2v);

% Form output
q = [qs qv];