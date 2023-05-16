
qCmd = [0.5417    0.5417   -0.4545   -0.4545];
qState = [0.5417    0.5417   -0.4545   -0.4545];

qCmdVec   = squeeze(out.quatCmd.Data(1,:,:))';
qStateVec = squeeze(out.quatState.Data(1,:,:))';

idx = 7320;   % after 20 sec
% idx = 33840;
idx = 24865;  % after 50 sec

qCmdVec   = squeeze(out.quatCmd.Data(1,:,idx));
qCmdBaseVec   = squeeze(out.quatCmdBase.Data(:,1,idx))';
qStateVec = squeeze(out.quatState.Data(1,:,idx));
eeCmdVec  = squeeze(out.eeCmd_RelWorld.Data(1,4:6,idx));
eeStateVec = out.ee_state.rotation.euler.Data(idx,:);

npts = size(qCmdVec,1);

for i = 1:npts
    eeCmd = eeCmdVec(i,:);
    eeState = eeStateVec(i,:);
%     qCmd = quatconj(qCmdVec(i,:));
    qCmd = qCmdVec(i,:);
    qState = (qStateVec(i,:));

    q1 = quatnorm(quatmult(qCmd,qState));
    q2 = quatnorm(quatmult(quatconj(qCmd),qState));
    q3 = quatnorm(quatmult(qCmd,quatconj(qState)));
    q4 = quatnorm(quatmult(quatconj(qCmd),quatconj(qState)));

    q5 = quatnorm(quatmult(qState,qCmd));
    q6 = quatnorm(quatmult(quatconj(qState),qCmd));
    q7 = quatnorm(quatmult(qState,quatconj(qCmd))); % Should be correct
    q8 = quatnorm(quatmult(quatconj(qState),quatconj(qCmd)));

    dcm1=quatToDCM(q1);
    dcm2=quatToDCM(q2);
    dcm3=quatToDCM(q3);
    dcm4=quatToDCM(q4);
    dcm5=quatToDCM(q5);
    dcm6=quatToDCM(q6);
    dcm7=quatToDCM(q7);
    dcm8=quatToDCM(q8);

    e1 = quatToEuler_321(q1)*180/pi;
    e2 = quatToEuler_321(q2)*180/pi;
    e3 = quatToEuler_321(q3)*180/pi;
    e4 = quatToEuler_321(q4)*180/pi;
    e5 = quatToEuler_321(q5)*180/pi;
    e6 = quatToEuler_321(q6)*180/pi;
    e7 = quatToEuler_321(q7)*180/pi;
    e8 = quatToEuler_321(q8)*180/pi;
    [y,p,r] = quat2angle(q1);
    e9 = [r p y]*180/pi;
    [y,p,r] = quat2angle(q2);
    e10 = [r p y]*180/pi;
    [y,p,r] = quat2angle(q3);
    e11 = [r p y]*180/pi;
    [y,p,r] = quat2angle(q4);
    e12 = [r p y]*180/pi;
    [y,p,r] = quat2angle(q5);
    e13 = [r p y]*180/pi;
    [y,p,r] = quat2angle(q6);
    e14 = [r p y]*180/pi;
    [y,p,r] = quat2angle(q7);
    e15 = [r p y]*180/pi;
    [y,p,r] = quat2angle(q8);
    e16 = [r p y]*180/pi;

    eeError = (wrapTo2Pi(eeState)-wrapTo2Pi(eeCmd));
    edcm = EulerToDCM_321(eeError);

    qCmdtemp = [qCmd(2) qCmd(3) qCmd(4) qCmd(1)];
    qStatetemp = [qState(2) qState(3) qState(4) qState(1)];
    
    qmat = [ qCmdtemp(4)  qCmdtemp(3) -qCmdtemp(2) -qCmdtemp(1); ...
            -qCmdtemp(3)  qCmdtemp(4)  qCmdtemp(1) -qCmdtemp(2); ...
             qCmdtemp(2) -qCmdtemp(1)  qCmdtemp(4) -qCmdtemp(3); ...
             qCmdtemp(1)  qCmdtemp(2)  qCmdtemp(3)  qCmdtemp(4)];

    qmat2 = [ qCmdtemp(4)  qCmdtemp(3) -qCmdtemp(2)  qCmdtemp(1); ...
             -qCmdtemp(3)  qCmdtemp(4)  qCmdtemp(1)  qCmdtemp(2); ...
              qCmdtemp(2) -qCmdtemp(1)  qCmdtemp(4)  qCmdtemp(3); ...
             -qCmdtemp(1) -qCmdtemp(2) -qCmdtemp(3)  qCmdtemp(4)];
      
    qmat3 = [ qCmdtemp(4) -qCmdtemp(3)  qCmdtemp(2)  qCmdtemp(1); ...
              qCmdtemp(3)  qCmdtemp(4) -qCmdtemp(1)  qCmdtemp(2); ...
             -qCmdtemp(2)  qCmdtemp(1)  qCmdtemp(4)  qCmdtemp(3); ...
             -qCmdtemp(1) -qCmdtemp(2) -qCmdtemp(3)  qCmdtemp(4)];



     qErrortemp = qmat2*qStatetemp';
     qErrortemp = quatnorm(qErrortemp);
     
     qError = [qErrortemp(4) qErrortemp(1) qErrortemp(2) qErrortemp(3)];
     qErrorVec(i,:) = qError;
     eulerErrorVec(i,:) = quatToEuler_321(qError);
     eVec(i,:) = 2*atan2(norm(qError(2:4)),qError(1))*qError(2:4)/norm(qError(2:4));
end

