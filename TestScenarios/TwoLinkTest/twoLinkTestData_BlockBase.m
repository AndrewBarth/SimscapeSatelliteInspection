
config = 1;
% config 1: arms at center in x and z
% config 2: arms at top and front
% config 3: one arm top left, one arm bottom right


endTime = 50;
arm(1).nLink = 2;
arm(2).nLink = 2;

sat.service.mass = 2;
sat.service.radius = 0.25;
sat.service.length = 0.25;
sat.service.dimensions = [0.5 0.5 0.5];
% The following mass properties are derived from simscape
sat.service.Com = [0 0 0];
sat.service.MoI = [0.0833333 0.0833333 0.0833333];
sat.service.PoI = [0 0 0];
sat.service.IC.pose.position.x = 0.0;
sat.service.IC.pose.position.y = 0.0;
sat.service.IC.pose.position.z = 0.0;

% Initial Joint Angles and Rates
for i = 1:arm(1).nLink
    arm(1).smiData.RevoluteJoint(i).Rz.Pos = 0.0;
    % arm(1).smiData.RevoluteJoint(1).Rz.Pos = 30.0;
    % arm(1).smiData.RevoluteJoint(2).Rz.Pos = -45.0;
    q1(i) = arm(1).smiData.RevoluteJoint(i).Rz.Pos*dtr;
    qDot1(i) = 0.0;
end

% Initial Joint Angles and Rates
for i = 1:arm(2).nLink
    arm(2).smiData.RevoluteJoint(i).Rz.Pos = 0.0;
    % arm(2).smiData.RevoluteJoint(1).Rz.Pos = -20.0;
    % arm(2).smiData.RevoluteJoint(2).Rz.Pos = 30.0;
    q2(i) = arm(2).smiData.RevoluteJoint(i).Rz.Pos*dtr;
    qDot2(i) = 0.0;
end

% Configure each arm
left_arm  = configure2DOFArm(arm(1),q1,sat);
right_arm = configure2DOFArm(arm(2),q2,sat);

clear arm;   % Clear out remaining default data
arm(1) = left_arm;
arm(2) = right_arm;

mt = arm(1).massProperties.mt + arm(2).massProperties.mt - sat.service.mass;
arm(1).massProperties.mt = mt;
arm(2).massProperties.mt = mt;

arm(1).smiData.RigidTransform(1).angle = 0.0;
arm(1).thetaOffset = [0 0]*pi/180;
arm(1).DHparams(1,:) = [0 0.1351 0 0];
arm(1).Joint_Limits = [-2*pi 2*pi; -2*pi 2*pi];

arm(2).smiData.RigidTransform(1).angle = 0.0;
arm(2).thetaOffset = [0 0]*pi/180;
arm(2).DHparams(1,:) = [0 0.1351 0 0];
arm(2).Joint_Limits = [-2*pi 2*pi; -2*pi 2*pi];

% Configuration specific arm parameters
if config == 1
    arm(1).baseOffset = [0 0 -0.04];
    arm(1).armAttachPnt = [0 -0.25 0];
    arm(1).armAttachAngles = [0 0 -90]*pi/180;

    arm(2).baseOffset = [0 0 -0.04];
    arm(2).armAttachPnt = [0 0.25 0];
    arm(2).armAttachAngles = [0 0 90]*pi/180;
elseif config == 2
    arm(1).baseOffset = [0 0 -0.04];
    arm(1).armAttachPnt = [-.25 -0.25 .25];
    arm(1).armAttachAngles = [0 0 -90]*pi/180;
    
    arm(2).baseOffset = [0 0 -0.04];
    arm(2).armAttachPnt = [-.25 0.25 .25];
    arm(2).armAttachAngles = [0 0 90]*pi/180;

elseif config == 3
    arm(1).baseOffset = [0 0 -0.04];
    arm(1).armAttachPnt = [-.25 -0.25 .25];
    arm(1).armAttachAngles = [0 0 -90]*pi/180;

    arm(2).baseOffset = [0 0 -0.04];
    arm(2).armAttachPnt = [.25 0.25 -.25];
    arm(2).armAttachAngles = [0 0 90]*pi/180;
end

% Arm control parameters
massPct = [0.7285 0.2715];
inertiaPct = [0.8602 0.1398];

jointControlData.Kp = massPct*1.5;
jointControlData.Kd = massPct*0;
jointControlData.Ki = massPct*1.0;

jointControlData.Kp = massPct*.01;
jointControlData.Kd = massPct*0;
jointControlData.Ki = massPct*.01;

jointControlData.Kp = inertiaPct*.02;
jointControlData.Kd = inertiaPct*0.005;
jointControlData.Ki = inertiaPct*.1;

% jointControlData.Kp = inertiaPct*.1;
% jointControlData.Kd = inertiaPct*0.005;
% jointControlData.Ki = inertiaPct*.15;

jointControlData.Kp = inertiaPct*.03;
jointControlData.Kd = inertiaPct*0.005;
jointControlData.Ki = inertiaPct*.1;

% Best values for 2 link test at center point
jointControlData.Kp = inertiaPct*.3;
jointControlData.Kd = inertiaPct*0.005;
jointControlData.Ki = inertiaPct*.2;

% inertiaPct = [1 0.1398];
% jointControlData.Kp = inertiaPct*.005;
% jointControlData.Kd = inertiaPct*0.000;
% jointControlData.Ki = inertiaPct*.01;

% % % inertiaPct = [1 0.1398];
% % % jointControlData.Kp = inertiaPct*1.8;
% % % jointControlData.Kd = inertiaPct*0.000;
% % % jointControlData.Ki = inertiaPct*5;
% % % 
% % % jointControlData.Kp = inertiaPct*0.8;
% % % jointControlData.Kd = inertiaPct*0.000;
% % % jointControlData.Ki = inertiaPct*.5;
busInfo = Simulink.Bus.createObject(jointControlData);
jointControlDataBus = evalin('base',busInfo.busName);

% Trajectory for arm 1
i=0;
 for t=0:.001:endTime
    i=i+1;
    acc1(i) = 0.00088;
    vel1(i) = acc1(i)*t;
    ang1(i) = q1(1) + 0.5*acc1(i)*t^2;
    acc2(i) = 0.00088;
    vel2(i) = acc2(i)*t;
    ang2(i) = q1(2) + 0.5*acc2(i)*t^2;
end
tVec=0:stepSize:endTime;
zeroVec=zeros(1,length(tVec));

% angles=[ang1; ang2];
% rates=[vel1; vel2];
angles=[ang1; zeroVec];
rates=[vel1; zeroVec];

prescribed_jointAngles = timeseries(angles,tVec);
prescribed_jointRates = timeseries(rates,tVec);

clear acc1 vel1 ang1 acc2 vel2 ang2  angles rates
clear q1 qdot1 q2 qdot2

% Define a Simulink parameter to store the number of links
% This was necessary for Simulink to allow arrays to be sized by nLink
NLINKS = Simulink.Parameter;
NLINKS.Value = 2;
NLINKS.CoderInfo.StorageClass = 'Auto';
NLINKS.CoderInfo.Alias = '';
NLINKS.CoderInfo.Alignment = -1;
NLINKS.CoderInfo.CustomStorageClass = 'Define';
NLINKS.CoderInfo.CustomAttributes.HeaderFile = '';
NLINKS.CoderInfo.CustomAttributes.ConcurrentAccess = false;
NLINKS.CoderInfo.Alias = '';
NLINKS.CoderInfo.Alignment = -1;
NLINKS.Description = 'The number of links';
NLINKS.DataType = 'uint8';
NLINKS.Min = [];
NLINKS.Max = [];
NLINKS.DocUnits = '';