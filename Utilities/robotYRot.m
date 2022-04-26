function [mat] = robotYRot(angle)

% Compute a single axis rotation matrix about the Y axis 
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
mat = [cos(angle) 0 sin(angle); 0 1 0; -sin(angle) 0 cos(angle)];