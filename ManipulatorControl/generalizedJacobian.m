function Jstar = generalizedJacobian(geometry,HoInv,Hom,nLink)
% Function to compute the generalized Jacobian matrix
%
% Inputs: geometry:       structure containing geometry parameters
%         HoInv:          inverse of base spacecraft inertia matrix
%         Hom:            dynamic inertia coupling matrix
%         nLink:          number of links in arm
%
% Output: Jstar:          generalized Jacobian matrix
%
% Assumptions and Limitations:
%   Computed with respect to the end effector (the last link)
%
% Dependencies:
%   skewMat
%
% References:
%    1. Wilde, Markus, et al. "Equations of Motion of Free-Floating 
%          Spacecraft-Manipulator Systems: An Engineer's Tutorial." 
%          Frontiers in Robotics and AI 5 (2018): 41.
%
% Author: Andrew Barth
%
% Modification History:
%    Oct 19 2018 - Initial version
%    Mar 15 2022 - Added array sizing for Simulink implementation
%    Jan 13 2023 - Used last element of pVec for end effector position
%

% Extract variables from structure for convenience
rVec = geometry.rVec;
pVec = geometry.pVec;
kVec = geometry.kVec;
p0 = geometry.rBase;

% Intialize array sizes
Jmxi = zeros(6,nLink);

% Set to use end effector as the end link
endLink = nLink;
i = endLink;
    for j = 1:endLink
        kSkew = skewMat(kVec(j,:));
        Jmxi(1:3,j) = kSkew*(pVec(i+1,:) - pVec(j,:))';  % Ref 1, Eq. 104
        Jmxi(4:6,j) = kVec(j,:)';                        % Ref 1, Eq. 104
    end
xoi = pVec(i+1,:) - p0;                                  % Ref 1, Eq. 106
% Joxi = [eye(3,3) skewMat(xoi); zeros(3,3) eye(3,3)];     % Ref 1, Eq. 105
Joxi = [eye(3,3) skewMat(-1*xoi); zeros(3,3) eye(3,3)];     % Ref 1, Eq. 105

% Compute generalzed Jacobian
Jstar = Jmxi - Joxi*HoInv*Hom;    % Ref 1, Eq. 110
% Jstar = Jmxi;    % Ref 1, Eq. 110
