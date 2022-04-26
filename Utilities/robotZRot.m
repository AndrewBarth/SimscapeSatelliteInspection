function [mat] = robotZRot(angle)

% Compute a single axis rotation matrix about the Z axis
%
% Inputs: Angle (rad)
%
% Output: 3x3 rotation matrix
%
% Assumptions and Limitations:
%   (none)
% References:
%   (none)
% Author: Andrew Barth
%
% Modification History:
%    Sep 17 2018 - Initial version
%
mat = [cos(angle) -sin(angle) 0; sin(angle) cos(angle) 0; 0 0 1];