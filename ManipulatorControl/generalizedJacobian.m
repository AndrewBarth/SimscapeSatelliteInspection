function Jstar = generalizedJacobian(geometry,HoInv,Hom,nLink)
% Function to compute the joint control torques
%
% Modification History:
%    Mar 01 2022 - Initial version
%
% References:
%    1. Wilde, Markus, et al. "Equations of Motion of Free-Floating 
%          Spacecraft-Manipulator Systems: An Engineer's Tutorial." 
%          Frontiers in Robotics and AI 5 (2018): 41.
%

rVec = geometry.rVec;
pVec = geometry.pVec;
kVec = geometry.kVec;
p0 = geometry.rBase;

Jmxi = zeros(6,nLink);
endLink = nLink;
%for i = 1:endLink
    i = endLink;
        for j = 1:endLink
            kSkew = skewMat(kVec(j,:));
            Jmxi(1:3,j) = kSkew*(rVec(i,:) - pVec(j,:))';  % Ref 1, Eq. 104
            Jmxi(4:6,j) = kVec(j,:)';                      % Ref 1, Eq. 104
        end
    xoi = rVec(i,:) - p0;
    Joxi = [eye(3,3) skewMat(xoi); zeros(3,3) eye(3,3)];   % Ref 1, Eq. 105
%end

Jstar = Jmxi - Joxi*HoInv*Hom;    % Ref 1, Eq. 110