
function [linkInertia,momentum,Hstar,Jstar,cstar] = armKinematics(x0,geometry,nLink,Link_Length,massProperties)


    % Update the geometry with the new state vector
%    [geometry] = computeGeometry(x0,nLink,Link_Length,massVec,Base_a,Base_c,Base_z);
    jAngle = zeros(1,nLink);
    qDot = zeros(nLink,1);
    Hstar = zeros(nLink,nLink);
    cstar = zeros(1,nLink);
    
    % Alias for joint angles and rates
    jAngle = x0(7:7+nLink-1);
    jRate  = x0(13+nLink:13+nLink+nLink-1);
    qDot   = jRate';
    
    [Ho, Hom, Hsq, Hm, Hstar, HstarInv, HoInv, linkInertia, Jt, Jr] = computeMassMatrix(x0,geometry,massProperties,nLink);
    
   
    
    [geometryDot,massPropertiesDot] = computeGeometryDot(x0,geometry,massProperties,nLink);
    
    [HoDot, HomDot, HsqDot, HmDot, HstarDot, JriDot, JtiDot] = computeMassMatrixDot(geometry,massProperties,geometryDot,massPropertiesDot,Hom,HoInv,Jr,Jt,nLink);
    
    [cstar] = computeCstar(geometry,massProperties,jAngle,qDot,Jt,Jr,Hom,HoInv,Link_Length,nLink);    
    
    Jstar = generalizedJacobian(geometry,HoInv,Hom,nLink);

%    [tau,cntrlError] = computeControlTorque(controlData,qDot,jAngle',eeState,Hstar,Jstar,cstar);
    
%    qDDot = HstarInv*(tau + HstarDot*qDot' - cstar');  % Ref 1, Eq. 47
%     
     nState = size(x0,1);
%     dx0(1:6+nLink,t+1) = x0(6+nLink+1:nState,t);
%     dx0(6+nLink+1:nState,t+1) = [0 0 0 0 0 0 qDDot'];
     momTerm1 = Ho*x0(6+nLink+1:6+nLink+6);
     momTerm2 = Hom*x0(12+nLink+1:nState);
     momentum = Ho*x0(6+nLink+1:6+nLink+6) + Hom*x0(12+nLink+1:nState);
%     
%     mDotTerm1(:,t) = Ho*dx0(6+nLink+1:6+nLink+6,t);
%     mDotTerm2(:,t) = Hom*dx0(12+nLink+1:nState,t);
%     mDotTerm3(:,t) = HoDot*dx0(1:6,t);
%     mDotTerm4(:,t) = HomDot*dx0(7:6+nLink,t);
%     
%     x0(:,t+1) = x0(:,t) + dx0(:,t+1)*dt;  
%     
%     massProperties(t+1) = massProperties(t);
%     
    
    
%     time(t+1) = time(t) + dt;
%     t = t + 1;
% end
% 
% % Update the geometry with the new state vector
% [geometry(t)] = computeGeometry(x0(:,t-1),nLink,Link_Length,massVec,Base_a,Base_c,Base_z);
% 
% momTerm1(:,t) = Ho*x0(6+nLink+1:6+nLink+6,t);
% momTerm2(:,t) = Hom*x0(12+nLink+1:nState,t);
% momentum(:,t) = Ho*x0(6+nLink+1:6+nLink+6,t) + Hom*x0(12+nLink+1:nState,t);
% mDotTerm1(:,t) = Ho*dx0(6+nLink+1:6+nLink+6,t);
% mDotTerm2(:,t) = Hom*dx0(12+nLink+1:nState,t);
% mDotTerm3(:,t) = HoDot*dx0(1:6,t);
% mDotTerm4(:,t) = HomDot*dx0(7:6+nLink,t);

