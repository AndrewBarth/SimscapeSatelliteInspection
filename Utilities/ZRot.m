function [mat] = ZRot(angle)
% Compute a single axis rotation matrix about the Z axis
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

mat = [ cos(angle) sin(angle)  0; ...
       -sin(angle) cos(angle)  0; ...
            0          0       1];