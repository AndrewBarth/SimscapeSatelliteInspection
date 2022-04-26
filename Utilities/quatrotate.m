function [vout] = quatrotate(vin,q)
% Function to perform a frame rotation on a vector using a quaternion
%
% Inputs: vin     input vector in frame A 3x1
%         q       quaternion rotation from A to B
% 
% Output: vout    output vector in frame B 3x1
%
% Assumptions and Limitations:
%    scalar is in first element of quaternion
%
% Dependencies:
%    quatmult
%    quatconj
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

% Add a zero scalar term to the input vector
qv = [0 vin'];

% Get the quaternion conjugate
qconj = quatconj(q);

% Perform quaternion rotations
% temp  = quatmult(q,qv);
% temp1 = quatmult(temp,qconj);

temp = quatmult(qconj,qv);
temp1 = quatmult(temp,q);
vout = temp1(2:4);