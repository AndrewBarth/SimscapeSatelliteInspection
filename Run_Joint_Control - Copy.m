

% ICs for integration
t = 1;
time(1) = 0;
tEnd = endTime;
% dt = 0.001;
dt = 0.05;
while time(t) <= tEnd

    % Update the geometry with the new state vector
    [geometry(t)] = computeGeometry(x0(:,t),nLink,Link_Length,massVec,Base_a,Base_c,Base_z);

    % Alias for joint angles and rates
    jAngle = x0(7:7+nLink-1,t);
    jRate  = x0(13+nLink:13+nLink+nLink-1,t);
    qDot   = jRate';
    
    [Ho, Hom, Hsq, Hm, Hstar, HstarInv, HoInv, massProperties(t), Jt, Jr] = computeMassMatrix(x0(:,t),geometry(t),massProperties(t),nLink);
    
    linkInertia = massProperties(t).linkInertia;
    
    [geometryDot(t),massPropertiesDot(t)] = computeGeometryDot(x0(:,t),geometry(t),massProperties(t),nLink);
    
    [HoDot, HomDot, HsqDot, HmDot, HstarDot, JriDot, JtiDot] = computeMassMatrixDot(geometry(t),massProperties(t),geometryDot(t),massPropertiesDot(t),Hom,HoInv,Jr,Jt,nLink);
    
    [cstar] = computeCstar(geometry(t),massProperties(t),jAngle,alpha,qDot,Jt,Jr,Hom,HoInv,Link_Length,nLink);    
    
    qDDot = HstarInv*(tau(:,t) + HstarDot*qDot' - cstar');  % Ref 1, Eq. 47
    
    nState = size(x0,1);
    dx0(1:6+nLink,t+1) = x0(6+nLink+1:nState,t);
    dx0(6+nLink+1:nState,t+1) = [0 0 0 0 0 0 qDDot'];
    momTerm1(:,t) = Ho*x0(6+nLink+1:6+nLink+6,t);
    momTerm2(:,t) = Hom*x0(12+nLink+1:nState,t);
    momentum(:,t) = Ho*x0(6+nLink+1:6+nLink+6,t) + Hom*x0(12+nLink+1:nState,t);
    
    mDotTerm1(:,t) = Ho*dx0(6+nLink+1:6+nLink+6,t);
    mDotTerm2(:,t) = Hom*dx0(12+nLink+1:nState,t);
    mDotTerm3(:,t) = HoDot*dx0(1:6,t);
    mDotTerm4(:,t) = HomDot*dx0(7:6+nLink,t);
    
    x0(:,t+1) = x0(:,t) + dx0(:,t+1)*dt;  
    
    massProperties(t+1) = massProperties(t);
    
    Jstar = generalizedJacobian(geometry,HoInv,Hom,nLink);

    tau(:,t+1) = computeControlTorque(qCmdDot,qDot,qCmd,jAngle',Kd,Kp,Hstar,cstar);
    
    time(t+1) = time(t) + dt;
    t = t + 1;
end

% Update the geometry with the new state vector
[geometry(t)] = computeGeometry(x0(:,t-1),nLink,Link_Length,massVec,Base_a,Base_c,Base_z);

momTerm1(:,t) = Ho*x0(6+nLink+1:6+nLink+6,t);
momTerm2(:,t) = Hom*x0(12+nLink+1:nState,t);
momentum(:,t) = Ho*x0(6+nLink+1:6+nLink+6,t) + Hom*x0(12+nLink+1:nState,t);
mDotTerm1(:,t) = Ho*dx0(6+nLink+1:6+nLink+6,t);
mDotTerm2(:,t) = Hom*dx0(12+nLink+1:nState,t);
mDotTerm3(:,t) = HoDot*dx0(1:6,t);
mDotTerm4(:,t) = HomDot*dx0(7:6+nLink,t);

