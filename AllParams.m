%% General parameters

% Set the run time of the simulation
endTime = 80;

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

    % Data from drawing on Trossen Robotics website (in mm)
    Link_Length(1) = 126.75 / 1000;
    Link_Length(2) = 300.00 / 1000;
    Link_Length(3) = 300.00 / 1000;
    Link_Length(4) = 70.0 / 1000;
    Link_Length(5) = 65.95 / 1000;
elseif ARM_TYPE == 2
    NLINKS.Value = 6;

    % Arbitary values (in m)
    Link_Length(1) = 126.75;
    Link_Length(2) = 300.00;
    Link_Length(3) = 300.00;
    Link_Length(4) = 70.0;
    Link_Length(5) = 65.95;
    Link_Length(6) = 10.0;
else
    NLINKS.Value = 3;

    % Data from Solidworks model (in m)
    Link_Length(1) = 0.2;
    Link_Length(2) = 0.2;
    Link_Length(3) = 0.08;
end
% Assumes CG is in the middle of the link
Link_CG = Link_Length/2;

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
jointControlData.Kp = [1 1 1]*0.7;
jointControlData.Kd = [1 1 1]*4;
jointControlData.Ki = [1 1 1]*0.;

% Used for joint control only (Joint control not implemented in Simulink)
jointControlData.qCmdDot = [0 0 0];
jointControlData.qCmd = [0 0 0]*pi/180;

% Used for end effector control [pos, ang, vel, angRate]
jointControlData.eeCmd = zeros(1,12);
jointControlData.eeRefTraj(1,:) = [-0.2     -0.0       0.2710 90.0*dtr 0.0  -80.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(2,:) = [-0.25     0.3       0.2710 90.0*dtr 0.0 -150.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(3,:) = [0.0       0.4       0.2710 90.0*dtr 0.0 -150.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(4,:) = [0         0.4       0.2710 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(5,:) = [0.4       0.6       0.2710 45.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];

% jointControlData.eeRefTraj(1,:) = [0.0      0.7       0.2710 90.0*dtr 0.0  90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(2,:) = [0.0      0.7       0.2710 90.0*dtr 0.0  90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(3,:) = [0.0       0.7       0.2710 90.0*dtr 0.0 90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(4,:) = [0.0       0.7       0.2710 90.0*dtr 0.0 90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(5,:) = [0.0       0.7       0.2710 90.0*dtr 0.0 90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];

jointControlData.refTime = [0 20 30 50 70];
jointControlData.jointControlMode = 0;
jointControlData.jointControlModeVec = [2 2 2 2 2];   % 1 = hold position, 2 = EE control
jointControlData.torqueLimit = 0.5*ones(1,nLink);

% Initial control torques
%tau(:,1) = [0 0 0]';

%% Satellite Control Parameters
% Translational commands and gains
%IC.rel_position = [-0.25 2.5 0.0];
satControlData.Trans.cmdVel = [0 0 0];

satControlData.Trans.Kp = [15 15 15];
satControlData.Trans.Kd = [120 120 120];
satControlData.Trans.Ki = [0.05 0.05 0.05];

satControlData.Trans.forceLimit = 20;

% Rotational commands and gains
% This is a relative angle and rate to the client
% If the client is rotating it will match the rate
satControlData.Rot.cmdAngle = [0 0 0]*dtr;
satControlData.Rot.cmdRate = [0 0 0]*dtr;

% satControlData.Rot.Kp = [50 50 50];
% satControlData.Rot.Kd = [200 200 200];
% satControlData.Rot.Ki = [0.05 0.05 0.05];
% Disable rotational control 
satControlData.Rot.Kp = [0 0 0];
satControlData.Rot.Kd = [0 0 0];
satControlData.Rot.Ki = [0 0 0];

satControlData.Rot.torqueLimit = 10;

%% Navigation Parameters
nav.CameraToBase.orientation = [-90 0 -45]*dtr;