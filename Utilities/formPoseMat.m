function [mat] = formPoseMat(rotMat,posVec)

% Compute a pose matrix
%
% Inputs: rotMat (3x3)
%         posVec (3x1)
%
% Output: 4x4 pose matrix
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
mat = [rotMat posVec; [0 0 0] 1];