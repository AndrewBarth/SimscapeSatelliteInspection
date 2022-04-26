function [AMat] = createDHMatrix(d,a,alpha,theta)

% Compute a pose matrix using Denavit-Hartenberg parameters
%
% Inputs: d:     distance along z axis
%         a:     distance along x axis
%         alpha: rotation about x axis
%         theta: rotation about z axis
%
% Output: 4x4 pose matrix
%
% Assumptions and Limitations:
%   (none)
%
% Dependencies:
%   formXRot
%   formZRot
%   formPoseMat
%
% References:
%   Manseur, R., "Robot Modeling and Kinematics", Da Vinci Engineering Press 2006
%
% Author: Andrew Barth
%
% Modification History:
%    Oct 19 2018 - Initial version
%    Apr  9 2020 - Changed utility names
%

identityRot = robotXRot(0.0);
TransZ = formPoseMat(identityRot, [0 0 d]');
RotZ = formPoseMat(robotZRot(theta), [0 0 0]');
TransX = formPoseMat(identityRot, [a 0 0]');
RotX = formPoseMat(robotXRot(alpha), [0 0 0]');

AMat = TransZ*RotZ*TransX*RotX;