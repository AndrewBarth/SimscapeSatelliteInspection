function [mrp] = quatToMRP(q)
% Function to convert a quaternion to a Modified Rodrigues Parameter representation
% 
% Inputs: q       quaternion 4x1
%
% Output: mrp     modified rodrigues parameters 3x1
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
%    Aug 08 2023 - Initial version
%

% Form Modified Rodrigues Parameters
mrp = [q(2)/(1+q(1));...
       q(3)/(1+q(1));...
       q(4)/(1+q(1))];

