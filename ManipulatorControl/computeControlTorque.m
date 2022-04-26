function [tau,cntrlSignal] = computeControlTorque(controlData,qDot,q,eeState,Hstar,Jstar,cstar)
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

cntrlError = zeros(12,1);
cntrlSignal = zeros(6,1);

if controlData.cntrlMode == 1
    qCmdDotX = reshape(controlData.qCmdDot,size(qDot));
    qCmdX = reshape(controlData.qCmd,size(q));
    KdX = reshape(controlData.Kd,size(q));
    KpX = reshape(controlData.Kp,size(q));

    % Compute joint acceleration
    uBar = KdX.*(qCmdDotX-qDot) + KpX.*(qCmdX - q);   % Ref 1, Eq. 112

    uBarX = reshape(uBar,size(q));
else
    % Control end effector
    posError = controlData.eeCmd(1:3)' - eeState(1:3);
    velError = controlData.eeCmd(7:9)' - eeState(7:9);
    angError = controlData.eeCmd(4:6)' - eeState(4:6);
    rateError = controlData.eeCmd(10:12)' - eeState(10:12);
    
    KdX = reshape(controlData.Kd,size(rateError));
    KpX = reshape(controlData.Kp,size(angError));
    transSignal = KdX.*velError + KpX.*posError;
    rotSignal = KdX.*rateError + KpX.*angError;
    
    cntrlSignal = [transSignal; rotSignal];
    cntrlError = [posError; angError; velError; rateError];

    JstarInv = pinv(Jstar);
    qAngles = JstarInv*cntrlSignal;
    %qAngles = Jstar\cntrlSignal;
    
    uBarX = reshape(qAngles,size(q));
end

tau = Hstar*uBarX' + cstar';                   % Ref 1, Eq. 115
