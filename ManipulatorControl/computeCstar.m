function [cstar] = computeCstar(geometry,massProperties,jAngle,qDot,Jt,Jr,Hom,HoInv,Link_Length,nLink)    


    T = zeros(nLink+1,4,4);
    dTJdk = zeros(nLink,4,4);
    dTLdk = zeros(nLink,4,4);
    dInertiadk = zeros(nLink,3,3);
    dHomdk = zeros(nLink,6,3);
    dHodk = zeros(nLink,6,6);
    dHstardk = zeros(nLink,3,3);
    cstar = zeros(1,nLink);
    
% Extract variables from structure for convenience
    T00      = geometry.T00;
    PoseMats = geometry.PoseMats;
    RL       = geometry.RL;
    rVec     = geometry.rVec;
    rVec0    = geometry.rVec0;
    pVec     = geometry.pVec;
    kVec     = geometry.kVec;
    alpha    = geometry.alpha;
    
    massVec        = massProperties.massVec;
    mt             = massProperties.mt;
    linkInertia    = massProperties.linkInertia;
    inertiaMat     = massProperties.inertiaMat;

% Update transform matrices to be expressed in the inertial frame
    for i = 1:nLink+1
        T(i,:,:) = T00*squeeze(PoseMats(:,:,i));
    end
    
    for k=1:nLink
        % Compute derivatives of tranform matrices with respect to each joint
        for i=1:nLink
            % Joint transforms
            if k > i-1
                dTJdk(i,:,:)  = zeros(4,4);                                         % Ref 1, Eq. 85            
            elseif k == i-1
                dAMat = derivDHMatrix(0,Link_Length(i-1),alpha(i-1),jAngle(i-1));
                dTJdk(i,:,:) = squeeze(T(i-1,:,:))*dAMat;                           % Ref 1, Eq. 86
            else
                dAMat = derivDHMatrix(0,Link_Length(k),alpha(k),jAngle(k));
                AMat = zeros(4,4);
                for l = k+1:i-1
                    AMat = AMat*createDHMatrix(0,Link_Length(l),alpha(l),jAngle(l));
                end
                dTJdk(i,:,:) = squeeze(T(k,:,:))*dAMat*AMat;                         % Ref 1, Eq. 87
            end
            % Link transforms
            if k > i
                dTLdk(i,:,:)  = zeros(4,4);                                         % Ref 1, Eq. 89
            elseif k == i
                dAMat = derivDHMatrix(0,Link_Length(i),alpha(i),jAngle(i));
                dTLdk(i,:,:) = squeeze(T(i,:,:))*dAMat;                             % Ref 1, Eq. 90
            else
                AMat = createDHMatrix(0,Link_Length(i),alpha(i),jAngle(i));
                dTLdk(i,:,:) = squeeze(dTJdk(i,:,:))*AMat;                                   % Ref 1, Eq. 91
            end
        end
       
        % Compute derivatives of Jacobians
        dJridk = zeros(nLink,3,nLink);
        dJTidk = zeros(nLink,3,nLink);
        for i = 1:nLink
            for j = 1:i
                dJridk(i,:,j) = squeeze(dTJdk(j,1:3,1:3))*[0 0 1]' ;               
                dJTidk(i,:,j) = skewMat(squeeze(dTJdk(j,1:3,1:3))*[0 0 1]')*(rVec(i,:)-pVec(j,:))' + ...
                                skewMat(kVec(j,:))*(dTLdk(i,1:3,4)-dTJdk(j,1:3,4))';     % Ref 1, Eq. 94
            end
        end
        
        for i = 1:nLink
            dInertiadk(i,:,:) = squeeze(dTLdk(i,1:3,1:3))*squeeze(inertiaMat(i,:,:))*squeeze(RL(i,:,:))' + ...
                                squeeze(RL(i,:,:))*squeeze(inertiaMat(i,:,:))*squeeze(dTLdk(i,1:3,1:3))';
        end
        
        dHmdk = zeros(nLink,3,3);
        dJtsdk = zeros(nLink,3,3);
        dHsqdk = zeros(nLink,3,3);
        dHsdk = zeros(nLink,3,3);
        drocdk = zeros(nLink,3);
        for i = 1:nLink
            Jti = squeeze(Jt(i,:,:));
            Jri = squeeze(Jr(i,:,:));
            % Form joint-angle derivative of Manipulator Inertia Matrix
            dHmdk(k,:,:) = squeeze(dHmdk(k,:,:)) + squeeze(dTJdk(i,1:3,1:3))'*squeeze(linkInertia(i,:,:))*Jri + ...
                                          Jri'*squeeze(dInertiadk(i,:,:))*Jri + ...
                                          Jri'*squeeze(linkInertia(i,:,:))*squeeze(dJridk(i,:,:)) + ...
                                          massVec(i)*squeeze(dJTidk(i,:,:))'*Jti + ...
                                          massVec(i)*Jti'*squeeze(dJTidk(i,:,:));          % Ref 1, Eq. 82
            % Form joint-angle derivative of Dynamic Coupling Matrix
            dJtsdk(k,:,:) = squeeze(dJtsdk(k,:,:)) + massVec(i)*squeeze(dJTidk(i,:,:));    % Ref 1, Eq. 96
            dHsqdk(k,:,:) = squeeze(dHsqdk(k,:,:)) + squeeze(dInertiadk(i,:,:))*Jri + ...
                            squeeze(linkInertia(i,:,:))*squeeze(dJridk(i,:,:)) + ...       % Ref 1, Eq. 97
                            massVec(i)*(skewMat(squeeze(dTLdk(i,1:3,4)))*Jti + skewMat(rVec0(i,:))*squeeze(dJTidk(i,:,:)));      
                        
            % Form joint-angle derivative of Base-Spacecraft Inertia Matrix
            drocdk(k,:) = drocdk(k,:) + massVec(i)*squeeze(dTLdk(i,1:3,4));
            dHsdk(k,:,:) = squeeze(dHsdk(k,:,:)) + squeeze(dInertiadk(i,:,:)) - ...
                           massVec(i)*(skewMat(squeeze(dTLdk(i,1:3,4)))*skewMat(rVec0(i,:)) + ...
                           skewMat(rVec0(i,:))*skewMat(squeeze(dTLdk(i,1:3,4))));         % Ref 1, Eq.101
        end
        drocdk(k,:) = drocdk(k,:)/sum(massVec);
        dHomdk(k,:,:) = [squeeze(dJtsdk(k,:,:)); squeeze(dHsqdk(k,:,:))];
        dHodk(k,:,:) = [zeros(3,3) -mt*skewMat(drocdk(k,:)); mt*skewMat(drocdk(k,:)) skewMat(dHsdk(k,:,:))];
        
        dHstardk(k,:,:) = squeeze(dHmdk(k,:,:)) - squeeze(dHomdk(k,:,:))'*HoInv*Hom - ...
                          Hom'*HoInv*squeeze(dHomdk(k,:,:)) + Hom'*HoInv*squeeze(dHodk(k,:,:))*HoInv*Hom;  % Ref 1, Eq. 81
                      
        cstar(k) = -0.5*qDot*squeeze(dHstardk(k,:,:))*qDot';  % Ref 1, Eq. 80
    end