function [HoDot, HomDot, HsqDot, HmDot, HstarDot, JriDot, JtiDot] = computeMassMatrixDot(geometry,massProperties,geometryDot,massPropertiesDot,Hom,HoInv,Jr,Jt,nLink)

% Extract variables from structure for convenience
%     rBase = geometry.rBase;
%     RLbase = geometry.RLbase;
%     RL = geometry.RL;
%     RJbase = geometry.RLbase;
%     RJ = geometry.RJ;
    rVec  = geometry.rVec;
    rVec0 = geometry.rVec0;
    pVec  = geometry.pVec;
    kVec  = geometry.kVec;
    
    
    rVec0Dot = geometryDot.rVec0Dot;
    RJDot    = geometryDot.RJDot;
    rDot     = geometryDot.rDot;
    pDot     = geometryDot.pDot;
    mtRocDot = geometryDot.mtRocDot;
    
    massVec        = massProperties.massVec;
    linkInertia    = massProperties.linkInertia;
    inertiaBaseDot = massPropertiesDot.inertiaBaseDot;
    inertiaDot     = massPropertiesDot.inertiaDot;
    
    
%     inertiaMatbase = massProperties.inertiaMatbase;
%     inertiaMat = massProperties.inertiaMat;

    % Compute derivative of Base-Spacecraft inertia matrix
    HsDot = zeros(3,3);
    for i = 1:nLink       
        HsDot = HsDot + squeeze(inertiaDot(i,:,:)) - massVec(i+1)*(skewMat(rVec0Dot(i,:))*skewMat(rVec0(i,:)) + ...
                        skewMat(rVec0(i,:))*skewMat(rVec0Dot(i,:))) + inertiaBaseDot;   
    end
    HoDot = [zeros(3,3) -mtRocDot; mtRocDot HsDot];                        % Ref 1, Eq. 74
    
    % Compute derivative of manipulator inertia matrix
    HmDot  = zeros(nLink,nLink); 
    JtsDot = zeros(3,nLink);
    HsqDot = zeros(3,nLink);
    JriDot = zeros(3,nLink);
    JtiDot = zeros(3,nLink);
    for i = 1:nLink

        JtiDot = zeros(3,nLink);
        JriDot = zeros(3,nLink);
        for j = 1:i
            JriDot(:,j) = squeeze(RJDot(j,:,:))*[0 0 1]';                      % Ref 1, Eq. 71
            JtiDot(:,j) = skewMat(squeeze(RJDot(j,:,:))*[0 0 1]')*(rVec(i,:)-pVec(j,:))'+ ...
                          skewMat(kVec(j,:))*(rDot(i,:)-pDot(j,:))';     % Ref 1, Eq. 73
        end
        Jri = squeeze(Jr(i,:,:));
        Jti = squeeze(Jt(i,:,:));
        HmDot = HmDot + JriDot'*squeeze(linkInertia(i,:,:))*Jri + Jri'*squeeze(inertiaDot(i,:,:))*Jri + ...
                        Jri'*squeeze(linkInertia(i,:,:))*JriDot + massVec(i+1)*(JtiDot'*Jti + Jti'*JtiDot); % Ref 1, Eq. 66
                    
        JtsDot = JtsDot + massVec(i+1)*JtiDot;
        HsqDot = squeeze(inertiaDot(i,:,:))*Jri + squeeze(linkInertia(i,:,:))*JriDot + ...
                 massVec(i+1)*(skewMat(rVec0Dot(i,:))*Jti + skewMat(rVec0(i,:))*JtiDot);
    end
    HomDot = [JtsDot; HsqDot];
    
    % Compute Hstar Dot
    HstarDot = HmDot - (HomDot'*HoInv*Hom + Hom'*HoInv*HomDot - Hom'*HoInv*HoDot*HoInv*Hom);  % Ref 1, Eq. 65