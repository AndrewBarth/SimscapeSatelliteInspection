function [mat] = skewMat(vec)
% Compose a skew matrix given a vector
%
% Inputs: vec (3x1)
%
% Output: mat (3x3)
%
% Assumptions and Limitations:
%   (none)

% References:
%   (none)

% Author: Andrew Barth
%
% Modification History:
%    Mar 21 2019 - Initial version
%
mat = [0 -vec(3) vec(2); vec(3) 0 -vec(1); -vec(2) vec(1) 0];