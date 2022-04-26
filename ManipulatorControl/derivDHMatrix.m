function [dAMat] = derivDHMatrix(d,a,alpha,theta)

% Compute the derivative of a pose matrix with respect to theta
% using Denavit-Hartenberg parameters
%
% Inputs: d:     distance along z axis
%         a:     distance along x axis
%         alpha: rotation about x axis
%         theta: rotation about z axis
%
% Output: dAMat 4x4 derivative pose matrix
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
%   Wilde, Markus, et al. "Equations of Motion of Free-Floating 
%          Spacecraft-Manipulator Systems: An Engineer's Tutorial." 
%          Frontiers in Robotics and AI 5 (2018): 41.
%
% Author: Andrew Barth
%
% Modification History:
%    Sep 24 2020 - Initial version
%


identityRot = robotXRot(0.0);
TransZ = formPoseMat(identityRot, [0 0 d]');  
% RotZ = formPoseMat(robotZRot(theta), [0 0 0]');
RotZ = formPoseMat([-sin(theta) -cos(theta) 0; cos(theta) -sin(theta) 0; 0 0 1],[0 0 0]');
TransX = formPoseMat(identityRot, [a 0 0]');
RotX = formPoseMat(robotXRot(alpha), [0 0 0]');

dAMat = TransZ*RotZ*TransX*RotX;

% Third and fourth rows do not depend on theta so derivative is 0
dAMat(3,:) = [0 0 0 0];
dAMat(4,:) = [0 0 0 0];