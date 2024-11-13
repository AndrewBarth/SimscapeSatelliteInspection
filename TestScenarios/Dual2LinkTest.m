 
config = 3;
% config 1: octagon base arms at front, center, side mount
% config 2: octagon base, arms at front, 45 deg, side mount
% config 3: octagon base arms at front, center, front mount

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

    % inertiaPct = [1.0 0.5376  .0751 1 1 1];
    inertiaPct = [1 1 1 0 0 0];
    jointControlData.Kp = inertiaPct*.1;
    jointControlData.Kd = inertiaPct*0;
    jointControlData.Ki = inertiaPct*.1;
    jointControlData.Kp = inertiaPct*1;
    jointControlData.Kd = inertiaPct*0;
    jointControlData.Ki = inertiaPct*1;
    
    % jointControlData.Kp = .075*[1 1 1 1 1 1];
    jointControlData.Kp = .075*[8 1 1 0 0 .5];
    % jointControlData.Kd = inertiaPct*.015.*[1 1 1 1 1 1];
    jointControlData.Kd = .015.*[1 1 1 1 1 80];
    % jointControlData.Ki = inertiaPct*.002;
    jointControlData.Ki = .0005.*[1 1 1 0 0 .5];

    % No control
    % jointControlData.Kp = inertiaPct*0;
    % jointControlData.Kd = inertiaPct*0;
    % jointControlData.Ki = inertiaPct*0;

    jointControlData.Kp = .0075*[1 1 1 0 0 .5];
    % jointControlData.Kd = inertiaPct*.015.*[1 1 1 1 1 1];
    jointControlData.Kd = .15.*[1 1 1 1 1 80];
    % jointControlData.Ki = inertiaPct*.002;
    jointControlData.Ki = .0005.*[1 1 1 0 0 .5];
jointControlData.torqueLimit = 1e-2*ones(1,nLink);

Base_length = 0.1;
Base_height = 0.00;
Base_width = 0.05;


if config == 1
    arm(1).DHparams(1,:) = [0 0.1351 0 0];
    arm(2).DHparams(1,:) = [0 0.1351 0 0];

    arm(1).DHparams(1,:) = [0 0.3660 0 0];
    arm(2).DHparams(1,:) = [0 0.3660 0 0];
    % Define attach point for GNC
    arm(1).armAttachAngles = [  0 0 180]*pi/180;
    arm(2).armAttachAngles = [  0 0 0]*pi/180;
    arm(1).armAttachPnt = [0 sat.service.length/2-Base_width 0];
    arm(2).armAttachPnt = [0 sat.service.length/2-Base_width 0];

    % Define attach point for simscape model
    arm(1).armAttachOffset(1).orientation = [0 0 180]*pi/180;
    arm(2).armAttachOffset(1).orientation = [0 0 0]*pi/180;
    arm(1).armAttachOffset(1).translation = [ 0 -Base_length/2  0];
    arm(2).armAttachOffset(1).translation = [ 0 -Base_length/2  0];

elseif config == 2
    arm(1).DHparams(1,:) = [0 0.3660 pi 0];
    arm(2).DHparams(1,:) = [0 0.3660 0 0];

    arm(1).DHparams(1,:) = [0 0.1351 0 0];
    arm(2).DHparams(1,:) = [0 0.1351 0 0];
    
    % Define attach point for GNC
    arm(1).armAttachAngles = [  0 -45 180]*pi/180;
    arm(2).armAttachAngles = [  0 -45  0]*pi/180;
    arm(1).armAttachPnt = [ -1*((sat.service.radius)*cos(pi/8)*(cos(pi/4)))+Base_height*cos(pi/4) sat.service.length/2-Base_width (sat.service.radius)*cos(pi/8)*cos(pi/4)+Base_height*cos(pi/4)];
    arm(2).armAttachPnt = [  1*((sat.service.radius)*cos(pi/8)*(cos(pi/4)))+Base_height*cos(pi/4) sat.service.length/2-Base_width (sat.service.radius)*cos(pi/8)*cos(pi/4)-Base_height*cos(pi/4)];
    % arm(2).armAttachPnt = [  -1*((sat.service.radius)*cos(pi/8)*(cos(pi/4)))+Base_height*cos(pi/4) sat.service.length/2-Base_width -1*(sat.service.radius)*cos(pi/8)*cos(pi/4)-Base_height*cos(pi/4)];
 
    % Define attach point for simscape model
    arm(1).armAttachOffset(1).orientation = [0 -135 0]*pi/180;
    arm(2).armAttachOffset(1).orientation = [0 -45 0]*pi/180;
    arm(1).armAttachOffset(1).translation = [ 1*((sat.service.radius)*cos(pi/8)*(1-cos(pi/4)))+Base_height*cos(pi/4) -Base_length/2 (sat.service.radius)*cos(pi/8)*cos(pi/4)+Base_height*cos(pi/4)];
    arm(2).armAttachOffset(1).translation = [ -1*((sat.service.radius)*cos(pi/8)*(1-cos(pi/4)))+Base_height*cos(pi/4) -Base_length/2 (sat.service.radius)*cos(pi/8)*cos(pi/4)-Base_height*cos(pi/4)];

elseif config == 3
    arm(1).DHparams(1,:) = [0 0.1351 0 0];
    arm(2).DHparams(1,:) = [0 0.1351 0 0];

    arm(1).DHparams(1,:) = [0 0.135 0 0];
    arm(2).DHparams(1,:) = [0 0.135 0 0];
    % % arm(1).DHparams(1,:) = [0 0.3660 0 0];
    % % arm(2).DHparams(1,:) = [0 0.3660 0 0];
    % Define attach point for GNC
    arm(1).armAttachAngles = [  0 0 90]*pi/180;
    arm(2).armAttachAngles = [  0 0 90]*pi/180;
    arm(1).armAttachPnt = [-sat.service.radius*cos(pi/8)+Base_width sat.service.length/2 0];
    arm(2).armAttachPnt = [ sat.service.radius*cos(pi/8)-Base_width sat.service.length/2 0];

    % Define attach point for simscape model
    arm(1).armAttachOffset(1).orientation = [0 0 90]*pi/180;
    arm(2).armAttachOffset(1).orientation = [0 0 90]*pi/180;
    arm(1).armAttachOffset(1).translation = [ Base_width 0  0];
    arm(2).armAttachOffset(1).translation = [-Base_width 0  0];

    % starting pos -0.4172    0.2688         0  90.0000    0.0000  -80.0000 rel base
    % waypoint 1 -0.3276    0.7283    0.0000  90.0000    0.0000 -110.0000   rel base 
    % desired end point -0.2721   -0.5448    0.0000  90.0000         0   55.0000  rel world
    % desired end point -0.2721    0.9552    0.0000  90.0000         0   55.0000  rel base
    desired_ee_world_pos = [-0.2721    0.9552    0.0000];
    desired_ee_world_ori = [90.0     0.0000     55]*pi/180;
    jointControlData.eeRefTraj(1,:) = [-0.3276    0.7283    0.0000 90.0*dtr 0.0   110.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
    jointControlData.eeRefTraj(2,:) = [-0.2721    0.9552    0.0000 90.0*dtr 0.0   55.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
    jointControlData.eeRefTraj(3,:) = [-0.2721    0.9552    0.0000 90.0*dtr 0.0   55.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
    jointControlData.eeRefTraj(4,:) = [-0.3      0.4       0.2310 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
    jointControlData.eeRefTraj(5,:) = [-0.1    0.55       0.2710 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
    jointControlData.eeRefTraj(6,:) = [-0.1    0.55       0.2710 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
    
    jointControlData.eeRefTraj(1,:) = [-0.4172    0.2688         0 90.0*dtr 0.0   -80.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
    jointControlData.eeRefTraj(2,:) = [-0.3276    0.7283    0.0000 90.0*dtr 0.0   110.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
    jointControlData.eeRefTraj(3,:) = [-0.2721    0.9552    0.0000 90.0*dtr 0.0   55.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
    jointControlData.eeRefTraj(4,:) = [-0.3      0.4       0.2310 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
    jointControlData.eeRefTraj(5,:) = [-0.1    0.55       0.2710 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
    jointControlData.eeRefTraj(6,:) = [-0.1    0.55       0.2710 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
    jointControlData.refTime = [0 20 60 100 110 12000];

end