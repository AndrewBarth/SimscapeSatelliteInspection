function [geometryDot,massPropertiesDot] = computeGeometryDot(x0,geometry,massProperties,nLink)

% Assumptions and Limitations:
%   

% Author: Andrew Barth
%
% Modification History:
%    Oct 19 2018 - Initial version
%    Mar 15 2022 - Added array sizing for Simulink implementation
%

    omegaJ = zeros(nLink+1,3);
    RJDot = zeros(nLink+1,3,3);
    RLDot = zeros(nLink,3,3);
    rVec0Dot = zeros(nLink,3);
    rDot = zeros(nLink,3);
    rDot0 = zeros(nLink,3);
    pDot = zeros(nLink,3);
    inertiaDot = zeros(nLink,3,3);
    
% Extract variables from structure for convenience
    rBase = geometry.rBase;
    RLbase = geometry.RLbase;
    RL = geometry.RL;
    RJbase = geometry.RLbase;
    RJ = geometry.RJ;
    rVec  = geometry.rVec;
    rVec0 = geometry.rVec0;
    pVec  = geometry.pVec;
    kVec  = geometry.kVec;

    massVec = massProperties.massVec;
    inertiaMatBase = massProperties.inertiaMatBase;
    inertiaMat = massProperties.inertiaMat;

    % Compute joint frame and angular rates
    rIdx = 10+nLink;
    vIdx = 7+nLink;
    omegaJ(1,:) = x0(rIdx:rIdx+2);
    rcmDot = x0(vIdx:vIdx+2);
    jDIdx = 13+nLink;
    
    
    
    rBaseDot = rcmDot + skewMat(omegaJ(1,:))*rBase';
   
    RJbaseDot = skewMat(omegaJ(1,:))*RJbase;
    inertiaBaseDot = RJbaseDot*inertiaMatBase*RJbase' + RJbase*inertiaMatBase*RJbaseDot'; % Ref 1, Eq. 70
    
    for i = 2:nLink+1
        omegaJ(i,:) = omegaJ(i-1) + kVec(i-1,:)*x0(jDIdx+(i-2));      % Ref 1, Eq. 68
        RJDot(i,:,:) = skewMat(omegaJ(i,:))*squeeze(RJ(i,:,:));                % Ref 1, Eq. 67
    end
    mtRocDot = zeros(3,3);
    for i = 1:nLink
        % Compute velocity of the joints and links
        rDot(i,:)  = rcmDot +   skewMat(omegaJ(i,:))*rVec(i,:)';
        rDot0(i,:) = rBaseDot + skewMat(omegaJ(i,:))*rVec0(i,:)';
        pDot(i,:)  = rcmDot +   skewMat(omegaJ(i,:))*pVec(i,:)';

        RLDot(i,:,:) = RJDot(i+1,:,:);
        inertiaDot(i,:,:) = squeeze(RLDot(i,:,:))*squeeze(inertiaMat(i,:,:))*squeeze(RL(i,:,:))' + ...
                            squeeze(RL(i,:,:))*squeeze(inertiaMat(i,:,:))*squeeze(RLDot(i,:,:))';  % Ref 1, Eq. 70
                        
        temp = zeros(3,1);              
        for j = 1:i
            temp = temp + skewMat(squeeze(RJ(j,:,:))*[0 0 1]')*(rVec(i,:)-pVec(j,:))'*x0(jDIdx+(j-1));
        end   
        rVec0Dot(i,:) = skewMat(omegaJ(1,:))*(rVec(i,:)' - rBase(:)) + temp;
        mtRocDot = mtRocDot + massVec(i+1)*skewMat(rVec0Dot(i,:));           % Ref 1, Eq. 75                
    end
    

    geometryDot.mtRocDot = mtRocDot;
    geometryDot.rDot = rDot;
    geometryDot.rDot0 = rDot0;
    geometryDot.pDot = pDot;
    geometryDot.RJbaseDot = RJbaseDot;
    geometryDot.RJDot = RJDot;
    geometryDot.RLDot = RLDot;
    geometryDot.rVec0Dot = rVec0Dot;
    
    massPropertiesDot.inertiaBaseDot = inertiaBaseDot;
    massPropertiesDot.inertiaDot = inertiaDot;