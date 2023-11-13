

%% General parameters

% Set the run time and step size of the simulation
endTime = 49;
stepSize = 0.001;

%% Rod Parameters
% Properties of aluminum
alu.rho = 2700; % kg*m^3
alu.E   = 70;   % GPa
alu.G   = 26;   % GPa

% Properties of fiberglass
% https://en.wikipedia.org/wiki/List_of_materials_properties#Mechanical_properties
fibG.rho = 1.7;
%fibG.E = 17.2/4;

% Choose a fibG.E ~between 23 and 42 (Young's Modulus in MPa; this creates
% less vibrations, but still flexibility in the rod)
fibG.E = 26;
%

fibG.G = 26.0/4; % not sure of this value

%material = alu;
material = fibG;

% Beam length, in m
beam.L = 1;

% Properties of the wall
% wall.dim = [1.0 0.5 1.0];
% wall.rho = alu.rho;
% wall.clr = [0.4 0.4 0.4];
% w=0;
% wall.off = -w/4; % offset

% Properties of the beam
rod.length = 1;          % Length (m)
rod.radius = 0.0025;     % Radius (m)

rod.stiffness = 0.0001;  % Stiffness coefficient (s)
% beam.bet = 1e-4; % s
rod.N   = 2;             % Number of elements
% beam.clr = [0.8 0.8 0.8];

% % Properties of rigid tip of the beam
% t = 0.005;
% tip.t   = t/2;
% tip.rho = material.rho;
% tip.clr = [0.0 1.0 1.0];

% % Properties of graphic representations
% % of cross-sectional centers (reference,
% % centroid, shear center)
% grph.dim   = [t t t/2];
% grph.c.clr = [1.0 0.0 0.0];
% grph.r.clr = [0.0 0.6 0.0];
% grph.s.clr = [0.0 0.0 1.0];

% % Properties of marker for force/moment
% % application point
% mrkr.L   = t/2;
% mrkr.r   = 0.8*t/2;
% mrkr.clr = [1.0 1.0 0.0];

% Transformation from gripper attach point to the rod base
rod_base.offset = [0 0 0];

% Z - Y - X rotation sequence (angles in radians)
rod_base.rotation = [ 10 90 0]*pi/180;
rod_base.rotation = [ 0 90 0]*pi/180;

%% Satellite Parameters
dtr = pi/180;

% Mass Properties of servicing satellite
sat.service.mass = 150;
sat.service.radius = 0.25;
sat.service.length = 0.5;
% The following mass properties are derived from simscape
sat.service.Com = [0 0 0];
sat.service.MoI = [5.23993, 5.23993, 4.22985];
sat.service.PoI = [0 0 0];

% Solar panel masses are ignored by controller
sat.service.panel.mass = 0.25;
sat.service.panel.dim = [0.5 0.005 0.3];
sat.service.panel_mount.mass = 0.25;
sat.service.panel_mount.dim = [0.05 0.01 0.01];

% Initial state of servicing satellite
% Position in m
sat.service.IC.pose.position.x = 0.0;
sat.service.IC.pose.position.y = 0.0;
sat.service.IC.pose.position.z = 0.0;
% Velocity in m/s
sat.service.IC.twist.linear.x = 0.0;
sat.service.IC.twist.linear.y = 0.0;
sat.service.IC.twist.linear.z = 0.0;
% Attitude in rad Z-Y-X order and sequence
sat.service.IC.pose.orientation = [0 0.0 0]*dtr;
% Angular velocity in rad/s
sat.service.IC.twist.angular = [0.0 0.0 0.0]*dtr;

% Rotation from satellite body to camera attach point
% Angles in rad Z-Y-X order and sequence
sat.service.camera.attachOrientation = [-90 0 22.5]*dtr;

% Rotation from camera attach point to camera body frame
% Angles in rad Z-Y-X order and sequence
sat.service.camera.bodyOrientation = [45 0 90]*dtr;

sat.client.mass = 1000;
sat.client.dim = [1.0 0.5 1.0];
IC.rel_position = [-0.25 2 0.0] - [-0.2 0.5 -0.25];
% Attitude in rad Z-Y-X order and sequence
IC.rel_orientation = [0 0 0]*dtr;
% Angular velocity in rad/s
sat.client.IC.twist.angular = [0.0 0.0 0.0]*dtr;

%% Joint Control Parameters
% Script to define parameters used in the joint control algorithm.
% Some of these may now be redundant with the Simulink implementation

% Define a Simulink parameter to store the number of links
% This was necessary for Simulink to allow arrays to be sized by nLink
NLINKS = Simulink.Parameter;
NLINKS.Value = 0;
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

% Link length should be moment arm of link.
if ARM_TYPE == 1
    NLINKS.Value = 5;

    % Data Trossen Robotics URDF File
    Base_height = 79.00 / 1000;
    waist_offset = [0, 0, 0.079];
    shoulder_offset = [0, 0, 0.04805];
    elbow_offset = [0.05955, 0, 0.3];
    wrist_rotate_offset = [0.069744, 0, 0];
    gripper_link_offset = [0.042825, 0, 0];
    gripper_origin_offset = [0.005675, 0, 0];
    gripper_bar_offset = [0.025875, 0, 0];
    ee_gripper_origin_offset = [0.0385, 0, 0];
    ee_offset = wrist_rotate_offset + gripper_link_offset + ...
                gripper_origin_offset + gripper_bar_offset + ...
                ee_gripper_origin_offset;
    Link_Length(1) = 126.75 / 1000 - Base_height;
    Link_Length(2) = 300.00 / 1000;
    Link_Length(3) = 300.00 / 1000 + elbow_offset(1);
    Link_Length(4) = 0.0 / 1000;
    Link_Length(5) = ee_offset(1);

    arm1.Joint_Limits(1,:) = [-pi pi];
    arm1.Joint_Limits(2,:) = [-1.850049007113989 1.256637061435917];
    arm1.Joint_Limits(3,:) = [-1.762782544514273 1.605702911834783];
    arm1.Joint_Limits(4,:) = [-1.867502299633933 2.234021442552742];
    arm1.Joint_Limits(5,:) = [-pi pi];

elseif ARM_TYPE == 2
    NLINKS.Value = 6;

    % Arbitary values (in m)
    Link_Length(1) = ArmLink1_height;
    Link_Length(2) = 227.5 / 1000;
    Link_Length(3) = 227.5 / 1000;
    Link_Length(4) = 227.5 / 1000;
    Link_Length(5) = 227.5 / 1000;
    Link_Length(6) = 0.065;
%     Link_Length(5) = 65.95;
%     Link_Length(6) = 10.0;

    arm1.Joint_Limits(1,:) = [-2*pi 2*pi];
    arm1.Joint_Limits(2,:) = [-2*pi 2*pi];
    arm1.Joint_Limits(3,:) = [-2*pi 2*pi];
    arm1.Joint_Limits(4,:) = [-2*pi 2*pi];
    arm1.Joint_Limits(5,:) = [-2*pi 2*pi];
    arm1.Joint_Limits(6,:) = [-2*pi 2*pi];

elseif ARM_TYPE == 3
    NLINKS.Value = 7;

    Base_height = 0.04;
    Base_dia = 0.45;
    % CAD model values (in m)
    Link_Length(1) = 0.05 + 0.04 + 0.1;   % Attach base plus Base height plus shoulder 1
    Link_Length(2) = 0.35 - .15 + 0.075;   % subtract half of shoulder_2 and add radius of shoulder 3
%     Link_Length(3) = 0.20 / 2 + 1;     % half the length of shoulder 3 plus main link 1
    Link_Length(3) = (0.20 - .16/2) + 1;   % shoulder 3 minus radius of shoulder 2 plus main link 1
%     Link_Length(4) = 0.075 + 0.075;    % half elbow 1 plus radius elbow 2
    Link_Length(4) =  0.15 - 0.15/2 + 0.15/2; % subtract radius of main link 1 and add radius of elbow 2
%     Link_Length(5) = 0.2 - 0.06 + 1;   % subtract elbow joint 1 radius plus main link 2
    Link_Length(5) = (0.20 - .12/2) + 1;   % elbow 2 minus radius of elbow 1 pluse main link 2
%     Link_Length(6) = 0.075 + 0.075;    % half wrist 1 plus radius wrist 2
    Link_Length(6) = 0.15 - 0.15/2 + 0.15/2; % subtract radius of main link 2 and add radius of wrist 2
%     Link_Length(6) = 0.2 - 0.12/2;     % subtract radius of elbow 1
    Link_Length(7) = 0.2 - 0.06;       % subtract wrist joint 1 radius


    Link_CG(1,:) = [0 0 Link_Length(1)/2];
    Link_CG(2,:) = [0 0 Link_Length(2)/2];
    Link_CG(3,:) = [0 0 Link_Length(3)/2];
    Link_CG(4,:) = [0 0 -Link_Length(4)/2];
    Link_CG(5,:) = [0 0 Link_Length(5)/2];
    Link_CG(6,:) = [0 0 -Link_Length(6)/2];
    Link_CG(7,:) = [0 0 Link_Length(7)/2];

    arm1.Joint_Limits(1,:) = [-2*pi 2*pi];
    arm1.Joint_Limits(2,:) = [-2*pi 2*pi];
    arm1.Joint_Limits(3,:) = [-2*pi 2*pi];
    arm1.Joint_Limits(4,:) = [-2*pi 2*pi];
    arm1.Joint_Limits(5,:) = [-2*pi 2*pi];
    arm1.Joint_Limits(6,:) = [-2*pi 2*pi];
    arm1.Joint_Limits(7,:) = [-2*pi 2*pi];

else
    NLINKS.Value = 3;

    % Data from Solidworks model (in m)
    Link_Length(1) = 0.2;
    Link_Length(2) = 0.2;
    Link_Length(3) = 0.08;

%     Link_CG(1,:) = [0 0 Link_Length(1)/2];
%     Link_CG(2,:) = [0 0 Link_Length(2)/2];
%     Link_CG(3,:) = [0 0 Link_Length(3)/2];
    Link_CG(1,:) = [Link_Length(1)/2 0 0];
    Link_CG(2,:) = [Link_Length(2)/2 0 0];
    Link_CG(3,:) = [Link_Length(3)/2 0 0];

    arm1.Joint_Limits(1,:) = [-120 120]*pi/180;
    arm1.Joint_Limits(2,:) = [-120 120]*pi/180;
    arm1.Joint_Limits(3,:) = [-120 120]*pi/180;

end
% Assumes CG is in the middle of the link
% Link_CG = Link_Length/2;

nLink = NLINKS.Value;

% Initial Joint Angles and Rates
for i = 1:nLink
    q(i) = smiData.RevoluteJoint(i).Rz.Pos*dtr;
    qDot(i) = 0.0;
end

% Set up DH parameters
Base_z = 90*dtr;   % Rotation becase Y axis is the joint axis
alpha = zeros(1, nLink);

% Define arm controller data
jointControlData.cntrlMode = 2;   % 1: Joint Control, 2: EE control (Joint control not implemented in Simulink)
% jointControlData.Kp = [1 1 1 .1 .1 .1]*0.7;
jointControlData.Kp = [1 1 1 .2 .2 .2]*0.7;
jointControlData.Kd = [1 1 1 1 1 1]*4;
% jointControlData.Kd = [1 1 1 1 1 1]*0;
jointControlData.Ki = [1 1 1 1 1 1]*0.;

% Use these with 3-Link Planar arm
% jointControlData.Kp = [1 1 1 1 1 1]*0.7;   % when using angle errors
%jointControlData.Kd = [1 1 1 .8 .8 .8]*4;
jointControlData.Kp = [1 1 1 .05 .05 .05]*0.7; % when using MRP errors
jointControlData.Kd = [1 1 1 .08 .08 .08]*4;
% jointControlData.Kp = [1 1 1 .7 .7 .7]*0.7; % when using MRP errors
jointControlData.Kp = [1 1 1 2.5 2.5 2.5]*0.7; % when using MRP errors
% jointControlData.Kd = [1 1 1 4.0 4.0 4.0]*4;
jointControlData.Kd = [1 1 1 5.0 5.0 5.0]*4;
% jointControlData.Ki = [0 0 0 .08 .08 .08]*1.;
jointControlData.Ki = [0 0 0 .18 .18 .18]*1.;
% Used for joint control only (Joint control not implemented in Simulink)
jointControlData.qCmdDot = [0 0 0];
jointControlData.qCmd = [0 0 0]*pi/180;

% Used for end effector control [pos, ang, vel, angRate]
jointControlData.eeCmd = zeros(1,12);
% jointControlData.eeRefTraj(1,:) = [-0.2     -0.0       0.2710 90.0*dtr 0.0  -40.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(2,:) = [-0.25     0.3       0.2710 90.0*dtr 0.0 -150.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(3,:) = [0.0       0.4       0.2710 90.0*dtr 0.0 -150.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(4,:) = [0         0.4       0.2710 90.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(5,:) = [0.4       0.6       0.2710 90.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
%jointControlData.refTime = [0 20 30 50 70];

% jointControlData.eeRefTraj(1,:) = [-0.236    0.0438     0.2710 90.0*dtr 0.0  -100.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(2,:) = [-0.236     0.3       0.2710 90.0*dtr 0.0 -150.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(3,:) = [0.0       0.4       0.2710 90.0*dtr 0.0 -150.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(4,:) = [0         0.4       0.2710 90.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(5,:) = [0.4       0.6       0.2710 90.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];

jointControlData.eeRefTraj(1,:) = [-0.236    0.0438        0.2710 90.0*dtr 0.0  -100.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(2,:) = [-0.236    0.0438       0.2710 90.0*dtr 0.0 -150.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(3,:) = [0.0       0.4       0.2710 90.0*dtr 0.0 -150.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(4,:) = [0         0.4       0.2710 90.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(5,:) = [0.4       0.6       0.2710 90.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];

jointControlData.refTime = [0 50 60 70 80];
jointControlData.jointControlMode = 0;
jointControlData.jointControlModeVec = [2 2 2 2 2];   % 1 = hold position, 2 = EE control
jointControlData.torqueLimit = 0.5*ones(1,nLink);
% jointControlData.deadzone = 0.02*ones(1,nLink);
% jointControlData.deadzone = 0.001*ones(1,nLink);
jointControlData.deadzone = 0.0001*ones(1,nLink);

jointControlData.angleLimit = arm1.Joint_Limits;
jointControlData.rateLimit = 10*ones(1,nLink)*pi/180;

%% Satellite Control Parameters
% Translational commands and gains
%IC.rel_position = [-0.25 2.5 0.0];
satControlData_Trans.cmdVel = [0 0 0];

satControlData_Trans.Kp = [15 15 15];
satControlData_Trans.Kd = [120 120 120];
satControlData_Trans.Ki = [0.05 0.05 0.05];

satControlData_Trans.forceLimit = 20;

% Rotational commands and gains
% This is a relative angle and rate to the client
% If the client is rotating it will match the rate
satControlData_Rot.cmdAngle = [0 0 0]*dtr;
satControlData_Rot.cmdRate = [0 0 0]*dtr;

% satControlData_Rot.Kp = [50 50 50];
% satControlData_Rot.Kd = [200 200 200];
% satControlData_Rot.Ki = [0.05 0.05 0.05];
% Disable rotational control 
satControlData_Rot.Kp = [0 0 0];
satControlData_Rot.Kd = [0 0 0];
satControlData_Rot.Ki = [0 0 0];

satControlData_Rot.torqueLimit = 10;

%% Navigation Parameters
nav.CameraToBase.orientation = [-90 0 -45]*dtr;