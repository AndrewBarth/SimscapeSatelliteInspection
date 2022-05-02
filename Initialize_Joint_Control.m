% Script to define parameters used in the joint control algorithm.
% Some of these may now be redundant with the Simulink implementation

% Define a Simulink parameter to store the number of links
% This was necessary for Simulink to allow arrays to be sized by nLink
NLINKS = Simulink.Parameter;
NLINKS.Value = 3;
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

nLink = 3;

dtr = pi/180;

% Set the run time of the simulation
endTime = 80;

% Set up mass properties
m_base = sat.service.mass + smiData.Solid(1).mass;  % Sum satellite base and arm base 
m_link = [smiData.Solid(2).mass smiData.Solid(3).mass smiData.Solid(4).mass];
mt = m_base + sum(m_link);
massVec = [m_base m_link];

% NEED TO ADD IN INERTIA OF ARM BASE (also check order of PoI variables)
inertiaMatBase = [sat.service.MoI(1) sat.service.PoI(1) sat.service.PoI(2); ... 
                  sat.service.PoI(1) sat.service.MoI(2) sat.service.PoI(3); ...
                  sat.service.PoI(2) sat.service.PoI(3) sat.service.MoI(3)];
              
linkIdx = 1;
for i = 1:nLink
    inertiaMat(i,:,:) = [smiData.Solid(i+linkIdx).MoI(1) smiData.Solid(i+linkIdx).PoI(1) smiData.Solid(i+linkIdx).PoI(2); ... 
                         smiData.Solid(i+linkIdx).PoI(1) smiData.Solid(i+linkIdx).MoI(2) smiData.Solid(i+linkIdx).PoI(3); ...
                         smiData.Solid(i+linkIdx).PoI(2) smiData.Solid(i+linkIdx).PoI(3) smiData.Solid(i+linkIdx).MoI(3)]/1000/1000; % Convert from kg*mm2 to kg*m2
end
linkInertia = zeros(nLink,3,3);
massProperties(1).mt = mt;
massProperties(1).massVec = massVec;
massProperties(1).inertiaMatBase = inertiaMatBase;
massProperties(1).inertiaMat = inertiaMat;
massProperties(1).linkInertia = linkInertia;
% Solar panel mass properties are ignored for now

% Initial Joint Angles and Rates
q1 = smiData.RevoluteJoint(1).Rz.Pos*dtr;
q2 = smiData.RevoluteJoint(2).Rz.Pos*dtr;
q3 = smiData.RevoluteJoint(3).Rz.Pos*dtr;

q1Dot = 0.0;
q2Dot = 0.0;
q3Dot = 0.0;

q = [q1 q2 q3];
qDot = [q1Dot q2Dot q3Dot];

% Link length should be moment arm of link. Data from Solidworks model
Link_Length(1) = 0.2;
Link_Length(2) = 0.2;
Link_Length(3) = 0.08;
Link_CG(1) = Link_Length(1)/2;
Link_CG(2) = Link_Length(2)/2;
Link_CG(3) = Link_Length(3)/2;

% Set up DH parameters
Base_z = 90*dtr;   % Rotation becase Y axis is the joint axis
alpha = zeros(1, nLink);
DHparams(1,:) = [0.0 sat.service.radius 0.0 0.0];
DHparams(1,:) = [sat.service.radius sat.service.length/2 0.0*dtr Base_z];
for i = 1:nLink
    DHparams(i+1,:) = [0.0 Link_Length(i) 0.0 q(i)];
end

% Call forward kinematics to compute pose matrices (relative to spacecraft)
PoseMats = fKinematics(DHparams,'all');

Base_a = sat.service.radius; % This should be the base of the arm
Base_b = sat.service.radius;
Base_c = sat.service.length;

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
jointControlData.eeRefTraj(3,:) = [0.0       0.5       0.2710 90.0*dtr 0.0 -150.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(4,:) = [0.0       0.5       0.2710 90.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(5,:) = [0.0       0.8       0.2710 90.0*dtr 0.0   90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];

% jointControlData.eeRefTraj(1,:) = [0.0      0.7       0.2710 90.0*dtr 0.0  90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(2,:) = [0.0      0.7       0.2710 90.0*dtr 0.0  90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(3,:) = [0.0       0.7       0.2710 90.0*dtr 0.0 90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(4,:) = [0.0       0.7       0.2710 90.0*dtr 0.0 90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
% jointControlData.eeRefTraj(5,:) = [0.0       0.7       0.2710 90.0*dtr 0.0 90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];

jointControlData.refTime = [0 20 30 50 70];
jointControlData.jointControlMode = 0;
jointControlData.jointControlModeVec = [1 2 2 2 2];   % 1 = hold position, 2 = EE control
jointControlData.torqueLimit = 0.5*ones(1,nLink);

busInfo = Simulink.Bus.createObject(jointControlData);
jointControlDataBus = evalin('base',busInfo.busName);

% Initial State
rBase0  = [sat.service.IC.pose.position.x sat.service.IC.pose.position.y sat.service.IC.pose.position.z];
xcmDot = sat.service.IC.twist.linear.x;
ycmDot = sat.service.IC.twist.linear.y;
zcmDot = sat.service.IC.twist.linear.z;
phi   = sat.service.IC.pose.orientation(3);
theta = sat.service.IC.pose.orientation(1);
psi   = sat.service.IC.pose.orientation(2);
w_x   = sat.service.IC.twist.angular(1);
w_y   = sat.service.IC.twist.angular(2);
w_z   = sat.service.IC.twist.angular(3);

% Initial control torques
tau(:,1) = [0 0 0]';

% Compute initial geometry
%Rot_Inertial_To_SC = robotZRot(psi)*robotYRot(theta)*robotXRot(phi);
Rot_Inertial_To_SC = robotXRot(phi)*robotZRot(psi)*robotYRot(theta);
T00 = [ [Rot_Inertial_To_SC(1:3,1:3) [0 0 0]']; [0 0 0 1] ];
T10 = [PoseMats(1:3,1:3,1) PoseMats(1:3,4,1); [0 0 0 1] ];
T20 = [PoseMats(1:3,1:3,2) PoseMats(1:3,4,2); [0 0 0 1] ];
T30 = [PoseMats(1:3,1:3,3) PoseMats(1:3,4,3); [0 0 0 1] ];
T40 = [PoseMats(1:3,1:3,4) PoseMats(1:3,4,4); [0 0 0 1] ];

rBase = rBase0';

% Define location for the cg of the link with respect to base
rVec0(1,:) = T00(1:3,1:3)*T10(1:3,4) + T00(1:3,1:3)*T20(1:3,1:3)*[Link_CG(1) 0 0]';
rVec0(2,:) = T00(1:3,1:3)*T20(1:3,4) + T00(1:3,1:3)*T30(1:3,1:3)*[Link_CG(2) 0 0]';
rVec0(3,:) = T00(1:3,1:3)*T30(1:3,4) + T00(1:3,1:3)*T40(1:3,1:3)*[Link_CG(3) 0 0]';

% Define location for the cg of the link with respect to origin
for i = 1:nLink
    rVec(i,:) = rBase + rVec0(i,:)';
end

% Compute the system center of mass
msum = massVec(1)*rBase';
for i=1:nLink
    msum = msum + massVec(i+1)*rVec(i,1:3);
end
rcm = msum / mt;

% Set up the initial dynamic state
x0(:,1) = [rcm [phi theta psi] q [xcmDot ycmDot zcmDot] [w_x w_y w_z] qDot]';


