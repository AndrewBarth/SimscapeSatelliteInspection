
function [linkInertia,momentum,Hstar,Jstar,cstar,Hm] = armKinematics(x0,geometry,nLink,Link_Length,massProperties)
% Function to compute the inverse kinematics of the arm
%
% Inputs: x0:             state vector [position eulerAngles jointAngles
%                                       velocity angularRate jointRates]
%         geometry:       structure containing geometry parameters
%         nLink:          number of links in arm
%         Link_Length:    vector of link lengths
%         massProperties: structure containing mass property values
%
% Output: linkInertia:    inertia matrix of each link
%         momentum:       computed linear and angular momentum
%         Hstar:          generalized inertia matrix
%         Jstar:          generalized Jacobian matrix
%         cstar:          Coriolis term matrix
%
% Assumptions and Limitations:
%   (none)
%
% Dependencies:
%   computeMassMatrix
%   computeGeometryDot
%   computeMassMatrixDot
%   computeCstar
%   generalizedJacobian
%
% References:
%    1. Wilde, Markus, et al. "Equations of Motion of Free-Floating 
%          Spacecraft-Manipulator Systems: An Engineer's Tutorial." 
%          Frontiers in Robotics and AI 5 (2018): 41.
%
% Author: Andrew Barth
%
% Modification History:
%    Mar 15 2022 - Initial version
%

% Initialize data sizes
jAngle = zeros(1,nLink);
qDot = zeros(nLink,1);
Hstar = zeros(nLink,nLink);
cstar = zeros(1,nLink);

% Alias for joint angles and rates
jAngle = x0(7:7+nLink-1);
jRate  = x0(13+nLink:13+nLink+nLink-1);
qDot   = jRate';


% Compute components of the generalized inertia matrix
[Ho, Hom, Hsq, Hm, Hstar, HstarInv, HoInv, linkInertia, Jt, Jr] = computeMassMatrix(x0,geometry,massProperties,nLink);

% Compute derivatives of the geometry data
[geometryDot,massPropertiesDot] = computeGeometryDot(x0,geometry,massProperties,nLink);

% Compute derivatives of the generalized inertia matrix
% (outputs not used in primary computation when initial momentum is zero) 
[HoDot, HomDot, HsqDot, HmDot, HstarDot, JriDot, JtiDot] = computeMassMatrixDot(geometry,massProperties,geometryDot,massPropertiesDot,Hom,HoInv,Jr,Jt,nLink);

% Compute the c star matrix
[cstar] = computeCstar(geometry,massProperties,jAngle,qDot,Jt,Jr,Hom,HoInv,Link_Length,nLink);    

% Compute the generalized jacobian matrix
Jstar = generalizedJacobian(geometry,HoInv,Hom,nLink);

% Compute linear and angular momentum     
 nState = size(x0,1);
 momTerm1 = Ho*x0(6+nLink+1:6+nLink+6);
 momTerm2 = Hom*x0(12+nLink+1:nState);
 momentum = Ho*x0(6+nLink+1:6+nLink+6) + Hom*x0(12+nLink+1:nState);
