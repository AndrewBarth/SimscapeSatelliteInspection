function [Ho, Hom, Hsq, Hm, Hstar, HstarInv, HoInv, linkInertia, Jt, Jr] = computeMassMatrix(x0,geometry,massProperties,nLink)
% Function to compute the generalized inertia matrix along with its
% components.
%
% Inputs: x0:             state vector [position eulerAngles jointAngles
%                                       velocity angularRate jointRates]
%         geometry:       structure containing geometry parameters
%         massProperties: structure containing mass property values
%         nLink:          number of links in arm
%
% Output: Ho:             base spacecraft inertia matrix
%         Hom:            dynamic inertia coupling matrix
%         Hsq:            joint rate contribution
%         Hm:             manipulator inertia matrix
%         Hstar:          generaized inertia matrix
%         HstarInv:       inverse of generaized inertia matrix
%         HoInv:          inverse of base spacecraft inertia matrix
%         linkInertia:    inertia of each link
%         Jt:             linear motion Jacobian
%         Jr:             angular motion Jacobian
%
% Assumptions and Limitations:
%   (none)
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
%

% Extract variables from structure for convenience
rBase = geometry.rBase;
RLbase = geometry.RLbase;
RL = geometry.RL;
rVec  = geometry.rVec;
rVec0 = geometry.rVec0;
pVec  = geometry.pVec;
kVec  = geometry.kVec;

massVec = massProperties.massVec;
mt = massProperties.mt;
inertiaMatBase = massProperties.inertiaMatBase;
inertiaMat = massProperties.inertiaMat;
linkInertia = zeros(nLink,3,3);

% Compute the vector from base to system center of mass
    roc = x0(1:3)' - rBase(:)';
    rocSkew = skewMat(roc);
    
    % Form the inertia matrix of the base - manipulator system
    Hs = RLbase*inertiaMatBase*RLbase';
    for i = 1:nLink
        % Convert the link inertias to the inertial frame
        linkInertia(i,:,:) = squeeze(RL(i,:,:))*squeeze(inertiaMat(i,:,:))*squeeze(RL(i,:,:))';
        rSkew = skewMat(rVec0(i,:));
        Hs = Hs + (squeeze(linkInertia(i,:,:)) - massVec(i+1)*rSkew*rSkew);
    end

    % Form the base-spacecraft inertia matrix
    Ho = [mt*eye(3,3) -mt*rocSkew; mt*rocSkew Hs];           % Ref 1, Eq. 28


    Jts = zeros(3,nLink);          % part of dynamic coupling inertia matrix
    Hsq = zeros(3,nLink);          % part of dynamic coupling inertia matrix
    Hm  = zeros(nLink,nLink);      % manipulator inertia matrix
    Jt = zeros(nLink,3,nLink);
    Jr = zeros(nLink,3,nLink);
    % Loop through each link and compute components of inertia matrix
    for i = 1:nLink
        for j = 1:i
            kSkew = skewMat(kVec(j,:));
            Jt(i,:,j) = kSkew*(rVec(i,:) - pVec(j,:))';      % Ref 1, Eq. 33
            Jr(i,:,j) = kVec(j,:);                           % Ref 1, Eq. 35
        end
        Jti = squeeze(Jt(i,:,:));
        Jri = squeeze(Jr(i,:,:));
        rSkew = skewMat(rVec0(i,:));
        Jts = Jts + massVec(i+1)*Jti;                        % Ref 1, Eq. 32
        Hsq = Hsq + (squeeze(linkInertia(i,:,:))*Jri + massVec(i+1)*rSkew*Jti);     % Ref 1, Eq. 34
        Hm  = Hm  + (Jri'*squeeze(linkInertia(i,:,:))*Jri + massVec(i+1)*Jti'*Jti); % Ref 1, Eq. 36
    end
    % Form dynamic coupling matrix
    Hom = [Jts;Hsq];                                         % Ref 1, Eq. 31

    % Inverse of Ho
    Su = Hs + mt*rocSkew*rocSkew;                            % Ref 1, Eq. 53
    invSu = Su\eye(size(Su));
    HoInv = [(1/mt*eye(3,3) - rocSkew*invSu*rocSkew) rocSkew*invSu; -invSu*rocSkew invSu]; % Ref 1, Eq. 52

    % H star (generalized inertia matrix)
    Hstar = Hm - Hom'*HoInv*Hom;                             % Ref 1, Eq. 45
    HstarInv = Hstar\eye(size(Hstar));
