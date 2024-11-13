% Default joint control parameters

% Some of these may now be redundant with the Simulink implementation

% Set up DH parameters
Base_z = 90*dtr;   % Rotation becase Y axis is the joint axis
alpha = zeros(1, nLink);

% Define arm controller data
jointControlData.cntrlMode = 2;   % 1: Joint Control, 2: EE control (Joint control not implemented in Simulink)

% Use these with 3-Link Planar arm
% jointControlData.Kp = [1 1 1 1 1 1]*0.7;   % when using angle errors
%jointControlData.Kd = [1 1 1 .8 .8 .8]*4;

jointControlData.Kp = [1 1 1 2.5 2.5 2.5]*0.7; % when using MRP errors
jointControlData.Kd = [1 1 1 5.0 5.0 5.0]*4;
jointControlData.Ki = [0 0 0 .18 .18 .18]*1.;
jointControlData.Kp = [0.1 0.1 0.1 1.0 1.0 1.0]*0.01; % when using quat errors
jointControlData.Kp = [0.1 0.1 0.1 1.0 1.0 1.0]*10; % when using joint rate errors
jointControlData.Ki = [0.1 0.1 0.1 0.1 0.1 0.1]*0.0;
jointControlData.Kd = [1 1 1 1.0 1.0 1.0]*0.0;
% Used for joint control only (Joint control not implemented in Simulink)
jointControlData.qCmdDot = [0 0 0];
jointControlData.qCmd = [0 0 0]*pi/180;


jointControlData.Kp = [1 1 1 1 1 1]*0.7;
jointControlData.Kd = [1 1 1 1 1 1]*4;
jointControlData.Ki = [1 1 1 1 1 1]*0.;

jointControlData.Kp = [3 3 3 2 2 2]*1.5;
jointControlData.Kd = [1 1 1 2 2 2]*4;
jointControlData.Ki = [1 1 1 2 2 2]*0.;

% Used for end effector control [pos, ang, vel, angRate]
jointControlData.eeCmd = zeros(1,12);

% From Summer2022dev
jointControlData.eeCmd = zeros(1,12);
jointControlData.eeRefTraj(1,:) = [-0.2     -0.0       0.2710 90.0*dtr 0.0  -80.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(2,:) = [-0.25     0.3       0.2710 90.0*dtr 0.0 -150.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(3,:) = [-0.1       0.4       0.2710 90.0*dtr 0.0 -150.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(4,:) = [0         0.4       0.2710 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(5,:) = [-0.1    0.55       0.2710 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(6,:) = [-0.1    0.55       0.2710 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];

% Baseline in disseration
jointControlData.eeRefTraj(1,:) = [-0.2362  0.1468     0.2310 90.0*dtr 0.0  -80.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(2,:) = [-0.0911  0.8302     0.2310 90.0*dtr 0.0   50.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(3,:) = [-0.3      0.4       0.2310 90.0*dtr 0.0 -150.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(4,:) = [-0.3      0.4       0.2310 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(5,:) = [-0.1    0.55       0.2710 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(6,:) = [-0.1    0.55       0.2710 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];

jointControlData.refTime = [0 20 60 100 110 12000];



if ARM_TYPE == 5
    % jointControlData.Kp = [1 1 1 1 1 1 1]*50.0;
    % jointControlData.Kd = [1 .5 .1 .05 .01 .005 .001]*0.01;
    % jointControlData.Ki = [1 1 1 1 1 1 1]*10.;
    % 
    massPct = [0.2746    0.2216    0.2055    0.1288    0.1128    0.0365  0.0203]; 
    jointControlData.Kp = massPct*200; 
    jointControlData.Kd = massPct*0.1;
    jointControlData.Ki = massPct*40;

elseif ARM_TYPE == 6
    massPct = [1.0  0.5785 0.1571 1 1 1];
    jointControlData.Kp = massPct*1.5;
    jointControlData.Kd = massPct*0;
    jointControlData.Ki = massPct*1.0;

    jointControlData.Kp = massPct*.15;
    jointControlData.Kd = massPct*0;
    jointControlData.Ki = massPct*.1;
end

jointControlData.jointControlMode = 0;
jointControlData.jointControlModeVec = [2 2 2 2 2];   % 1 = hold position, 2 = EE control
jointControlData.torqueLimit = 0.5*ones(1,nLink);

% jointControlData.deadzone = 0.02*ones(1,nLink);
% jointControlData.deadzone = 0.001*ones(1,nLink);
jointControlData.deadzone = 1e-4*ones(1,nLink);
% jointControlData.deadzone = 1e-10*ones(1,nLink);

jointControlData.angleLimit = arm(1).Joint_Limits;
jointControlData.rateLimit = 10*ones(1,nLink)*pi/180;

% Increasing rate limit
jointControlData.rateLimit = 20*ones(1,nLink)*pi/180;