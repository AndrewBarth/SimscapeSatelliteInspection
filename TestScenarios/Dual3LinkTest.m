 
config = 1;
% config 1: octagon base arms at front, center
% config 2: octagon base, arms at front, 45 deg

% Trajectory for arm 1
i=0;
 for t=0:.001:endTime
    i=i+1;
    acc(i) = 0.00088;
    vel(i) = acc(i)*t;
    ang(i) = 0.5*acc(i)*t^2;
end
tVec=0:stepSize:endTime;
zeroVec=zeros(1,length(tVec));

angles=[ang; zeroVec; zeroVec];
rates=[vel; zeroVec; zeroVec];

prescribed_jointAngles = timeseries(angles,tVec);
prescribed_jointRates = timeseries(rates,tVec);

clear acc vel ang angles rates

    massPct = [1.0  0.5785 0.1571];
    jointControlData.Kp = massPct*1.5;
    jointControlData.Kd = massPct*0;
    jointControlData.Ki = massPct*1.0;

    inertiaPct = [1.0 0.5376  .0751];
    jointControlData.Kp = inertiaPct*.1;
    jointControlData.Kd = inertiaPct*0;
    jointControlData.Ki = inertiaPct*.1;


Base_dia = 0.1;
Base_height = 0.00;
base_width = 0.05;


if config == 1
    arm(1).DHparams(1,:) = [0 0.1351 0 0];
    arm(2).DHparams(1,:) = [0 0.1351 0 0];

    arm(1).DHparams(1,:) = [0 0.3660 0 0];
    arm(2).DHparams(1,:) = [0 0.3660 0 0];
    % Define attach point for GNC
    arm(1).armAttachAngles = [  0 0 180]*pi/180;
    arm(2).armAttachAngles = [  0 0 0]*pi/180;
    arm(1).armAttachPnt = [0 sat.service.length/2-base_width 0];
    arm(2).armAttachPnt = [0 sat.service.length/2-base_width 0];

    % Define attach point for simscape model
    arm(1).armAttachOffset(1).orientation = [0 0 180]*pi/180;
    arm(2).armAttachOffset(1).orientation = [0 0 0]*pi/180;
    arm(1).armAttachOffset(1).translation = [ 0 -Base_dia/2  0];
    arm(2).armAttachOffset(1).translation = [ 0 -Base_dia/2  0];

elseif config == 2
    arm(1).DHparams(1,:) = [0 0.3660 pi 0];
    arm(2).DHparams(1,:) = [0 0.3660 0 0];

    % Define attach point for GNC
    arm(1).armAttachAngles = [  0 -45 180]*pi/180;
    arm(2).armAttachAngles = [  0 -45  0]*pi/180;
    arm(1).armAttachPnt = [ -1*((sat.service.radius)*cos(pi/8)*(cos(pi/4)))+Base_height*cos(pi/4) sat.service.length/2-base_width (sat.service.radius)*cos(pi/8)*cos(pi/4)+Base_height*cos(pi/4)];
    arm(2).armAttachPnt = [  1*((sat.service.radius)*cos(pi/8)*(cos(pi/4)))+Base_height*cos(pi/4) sat.service.length/2-base_width (sat.service.radius)*cos(pi/8)*cos(pi/4)-Base_height*cos(pi/4)];
    % arm(2).armAttachPnt = [  -1*((sat.service.radius)*cos(pi/8)*(cos(pi/4)))+Base_height*cos(pi/4) sat.service.length/2-base_width -1*(sat.service.radius)*cos(pi/8)*cos(pi/4)-Base_height*cos(pi/4)];
 
    % Define attach point for simscape model
    arm(1).armAttachOffset(1).orientation = [0 -135 0]*pi/180;
    arm(2).armAttachOffset(1).orientation = [0 -45 0]*pi/180;
    arm(1).armAttachOffset(1).translation = [ 1*((sat.service.radius)*cos(pi/8)*(1-cos(pi/4)))+Base_height*cos(pi/4) -Base_dia/2 (sat.service.radius)*cos(pi/8)*cos(pi/4)+Base_height*cos(pi/4)];
    arm(2).armAttachOffset(1).translation = [ -1*((sat.service.radius)*cos(pi/8)*(1-cos(pi/4)))+Base_height*cos(pi/4) -Base_dia/2 (sat.service.radius)*cos(pi/8)*cos(pi/4)-Base_height*cos(pi/4)];
end