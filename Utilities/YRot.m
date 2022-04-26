function [mat] = YRot(angle)
% Compute a single axis rotation matrix about the Y axis
%
% Inputs: Angle (rad)
%
% Output: 3x3 rotation matrix
%
% Assumptions and Limitations:
%   (none)
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
mat = [cos(angle) 0 -sin(angle); ...
            0     1      0; ...
       sin(angle) 0  cos(angle)];