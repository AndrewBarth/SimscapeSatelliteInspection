%% Rod Calculations
rod.rho = material.rho;  % Density (kg/m3)
rod.E   = material.E;    % Young's Modulous (GPa)
rod.G   = material.G;    % Shear Modulous (GPa)

%% Satellite Calculations
% None were needed for this method

%% Joint Control Calculations


% DH parameters order: [d a alpha theta]
%         d:     distance along z axis
%         a:     distance along x axis
%         alpha: rotation about x axis
%         theta: rotation about z axis
if ARM_TYPE == 1

    % Initial Joint Angles and Rates
    for i = 1:nLink
        q(i) = smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end
    armAttachPnt = [0 0 0];
    armAttachAngles = [0 0 0]*dtr;
    thetaOffset = [0 90 -90 90 0]*dtr;
%     DHparams(1,:) = [sat.service.radius sat.service.length/2 0.0*dtr Base_z];
%     DHparams(2,:) = [0.0 Link_Length(1) 0.0 q(1)+thetaOffset(1)];
%     DHparams(3,:) = [Link_Length(2) 0.0 90*dtr q(2)+thetaOffset(2)];
%     DHparams(4,:) = [0.0 Link_Length(3) 0.0 q(3)+thetaOffset(3)];
%     DHparams(5,:) = [0.0 Link_Length(4) 0.0 q(4)+thetaOffset(4)];
%     DHparams(6,:) = [Link_Length(5) 0.0  90*dtr q(5)+thetaOffset(5)];
%     DHparams(1,:) = [sat.service.radius*cos(pi/8)+Base_height sat.service.length/2 0.0*dtr Base_z];
    DHparams(1,:) = [0 sat.service.length/2 0.0*dtr Base_z];
    DHparams(2,:) = [Link_Length(1) 0.0  90.0*dtr q(1)+thetaOffset(1)];
    DHparams(3,:) = [0.0 Link_Length(2)   0.0*dtr q(2)+thetaOffset(2)];
    DHparams(4,:) = [0.0 Link_Length(3)  90.0*dtr q(3)+thetaOffset(3)];
    DHparams(5,:) = [0.0 Link_Length(4)  90.0*dtr q(4)+thetaOffset(4)];
    DHparams(6,:) = [Link_Length(5) 0.0   0.0*dtr q(5)+thetaOffset(5)];
    
    % Set up mass properties
    % THESE ARE PROBABLY INCORRECT. NEED TO MATCH THIS WITH ARM MODEL
    m_base = sat.service.mass + smiData.Solid(1).mass;  % Sum satellite base and arm base
    for i = 1:nLink
        m_link(i) = smiData.Solid(i+1).mass;
    end
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
    arm(1).massProperties.mt = mt;
    arm(1).massProperties.massVec = massVec;
    arm(1).massProperties.inertiaMatBase = inertiaMatBase;
    arm(1).massProperties.inertiaMat = inertiaMat;
    arm(1).massProperties.linkInertia = linkInertia;
    arm(1).thetaOffset = thetaOffset;
    arm(1).DHparams = DHparams;
    arm(1).thetaOffset = thetaOffset;
    arm(1).armAttachPnt = armAttachPnt;
    arm(1).armAttachAngles = armAttachAngles;

elseif ARM_TYPE == 2
    % Initial Joint Angles and Rates
    for i = 1:nLink
        q(i) = smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end

    armAttachPnt = [0 0 0];
    armAttachAngles = [0 0 0]*dtr;
    thetaOffset = [0 0 0 0 90 0]*dtr;
%     DHparams(1,:) = [sat.service.radius*cos(pi/8)+ArmBase_height sat.service.length/2 0.0*dtr Base_z];
%     DHparams(2,:) = [Link_Length(1) 0.0  90.0*dtr q(1)+thetaOffset(1)];
%     DHparams(3,:) = [0.0 Link_Length(2)   0.0     q(2)];
%     DHparams(4,:) = [0.0 Link_Length(3)   0.0     q(3)];
%     DHparams(5,:) = [0.0 Link_Length(4)  90.0*dtr q(4)];
%     DHparams(6,:) = [Link_Length(5) 0.0  90*dtr   q(5)+90*dtr];
%     DHparams(7,:) = [Link_Length(6) 0.0 -90*dtr   q(6)];

    DHparams(1,:) = [sat.service.radius*cos(pi/8)+ArmBase_height sat.service.length/2 0.0*dtr Base_z];
%     DHparams(2,:) = [Link_Length(1) 0.0  90.0*dtr q(1)];
%     DHparams(3,:) = [0.0 Link_Length(2)   0.0     q(2)];
%     DHparams(4,:) = [0.0 Link_Length(3)   0.0     q(3)];
%     DHparams(5,:) = [0.0 Link_Length(4)  90.0*dtr q(4)];
%     %DHparams(6,:) = [Link_Length(5) 0.0  90*dtr   q(5)+90*dtr];
%     DHparams(6,:) = [0.0 Link_Length(5)  90*dtr   q(5)+90*dtr];
%     %DHparams(6,:) = [0.0 Link_Length(5)  90*dtr   q(5)+0*dtr];
%     DHparams(7,:) = [Link_Length(6) 0.0225 -90*dtr   q(6)];
% 
%     DHparams(6,:) = [Link_Length(5) 0.0  90*dtr   q(5)+90*dtr];
%     %DHparams(6,:) = [0.0 Link_Length(5)  90*dtr   q(5)+90*dtr];
%     %DHparams(6,:) = [0.0 Link_Length(5)  90*dtr   q(5)+90*dtr];
%     DHparams(7,:) = [Link_Length(6) 0.0225 -90*dtr   q(6)];

    DHparams(2,:) = [Link_Length(1) 0.0  90*dtr  q(1)+thetaOffset(1)];
    DHparams(3,:) = [0.0 Link_Length(2)   0*dtr  q(2)+thetaOffset(2)];
    DHparams(4,:) = [0.0 Link_Length(3)   0*dtr  q(3)+thetaOffset(3)];
    DHparams(5,:) = [0.0 Link_Length(4)  90*dtr  q(4)+thetaOffset(4)];
    DHparams(6,:) = [0.0 0.0             90*dtr  q(5)+thetaOffset(5)];
    DHparams(7,:) = [Link_Length(5)+Link_Length(6) 0.0  -90*dtr  q(6)+thetaOffset(6)];

%     DHparams(1,:) = [Link_Length(1) 0.0  90*dtr  q(1)];
%     DHparams(2,:) = [0.0 Link_Length(2)   0*dtr  q(2)];
%     DHparams(3,:) = [0.0 Link_Length(3)   0*dtr  q(3)];
%     DHparams(4,:) = [0.0 Link_Length(4) -90*dtr  q(4)];
%     DHparams(5,:) = [0.0 Link_Length(5)  90*dtr  q(5)+90*dtr];
%     DHparams(6,:) = [Link_Length(6) 0.0   0*dtr  q(6)];
%     DHparams(7,:) = [0.0 0.0   0  0];

%     DHparams(1,:) = [0.8 0.0  90*dtr  0];
%     DHparams(2,:) = [0.0 7.0   0*dtr -1.6370*dtr];
%     DHparams(3,:) = [0.0 6.5   0*dtr  3.4005*dtr];
%     DHparams(4,:) = [0.0 0.4 -90*dtr -1.7630*dtr];
%     DHparams(5,:) = [0.0 0.0  90*dtr 90.0000*dtr];
%     DHparams(6,:) = [1.0 0.0   0*dtr  0*dtr];
%     DHparams(7,:) = [1.0 0.0   0*dtr  0*dtr];

    % Set up mass properties
    % THESE ARE PROBABLY INCORRECT. NEED TO MATCH THIS WITH ARM MODEL
    m_base = sat.service.mass + smiData.Solid(1).mass;  % Sum satellite base and arm base
    for i = 1:nLink
        m_link(i) = smiData.Solid(i+1).mass;
    end
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
    arm(1).massProperties.mt = mt;
    arm(1).massProperties.massVec = massVec;
    arm(1).massProperties.inertiaMatBase = inertiaMatBase;
    arm(1).massProperties.inertiaMat = inertiaMat;
    arm(1).massProperties.linkInertia = linkInertia;
    arm(1).thetaOffset = thetaOffset;
    arm(1).DHparams = DHparams;
    arm(1).thetaOffset = thetaOffset;
    arm(1).armAttachPnt = armAttachPnt;
    arm(1).armAttachAngles = armAttachAngles;

elseif ARM_TYPE == 3
    % Initial Joint Angles and Rates
    for i = 1:nLink
        q(i) = arm(1).smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end
%     armAttachPnt = [sat.service.radius*cos(pi/8)*cos(pi/4)
%                     sat.service.length/2-Base_dia/2
%                     sat.service.radius*cos(pi/8)*sin(pi/4)];
%     armAttachAngles = [-45 0 90]*dtr;


    arm(1).armAttachPnt = [0
                          sat.service.length/2-Base_dia/2
                          sat.service.radius*cos(pi/8)*sin(pi/4)];
    arm(1).armAttachAngles = [0 0 90]*dtr;
    arm_data = configure7DOFArm(arm(1),q,sat);

    clear arm;
    arm(1) = arm_data;
    arm(2).nLink = 0;

elseif ARM_TYPE == 4
    % Initial Joint Angles and Rates
    for i = 1:arm(1).nLink
        q(i) = arm(1).smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end
    left_arm = configure2DOFArm(arm(1),q,sat);
    right_arm = configure2DOFArm(arm(2),q,sat);
    clear arm
    arm(1) = left_arm;
    arm(2) = right_arm;

elseif ARM_TYPE == 5
    % Arm 1
    % Initial Joint Angles and Rates
    for i = 1:arm(1).nLink
        arm(1).smiData.RevoluteJoint(i).Rz.Pos = 0.0;
    end
    for i = 1:arm(1).nLink
        q(i) = arm(1).smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end

    arm(1).armAttachPnt = [0
                          sat.service.length/2-Base_dia/2
                          sat.service.radius*cos(pi/8)*sin(pi/4)];
    arm(1).armAttachAngles = [0 0 90]*dtr;

    left_arm = configure7DOFArm(arm(1),q,sat);

    % Arm 2
    % Initial Joint Angles and Rates
    for i = 1:arm(2).nLink
        arm(2).smiData.RevoluteJoint(i).Rz.Pos = 0.0;
    end
    for i = 1:arm(2).nLink
        q(i) = arm(2).smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end

    arm(2).armAttachPnt = [0
                           sat.service.length/2-Base_dia/2
                           sat.service.radius*cos(pi/8)*sin(pi/4)];
    arm(2).armAttachAngles = [0 0 90]*dtr;

    right_arm = configure7DOFArm(arm(2),q,sat);
    clear arm;
    arm(1) = left_arm;
    arm(2) = right_arm;

elseif ARM_TYPE == 6
    % Initial Joint Angles and Rates
    for i = 1:arm(1).nLink
        arm(1).smiData.RevoluteJoint(i).Rz.Pos = 0.0;
        q(i) = arm(1).smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end
    left_arm = configure3DOFArm(arm(1),q,sat);

    % Initial Joint Angles and Rates
    % arm(2).smiData.RevoluteJoint(1).Rz.Pos = 20.0;
    % arm(2).smiData.RevoluteJoint(2).Rz.Pos = 45.0;
    % arm(2).smiData.RevoluteJoint(3).Rz.Pos = -30.0;
    for i = 1:arm(2).nLink
        arm(2).smiData.RevoluteJoint(i).Rz.Pos = 0.0;
        q(i) = arm(2).smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end
    right_arm = configure3DOFArm(arm(2),q,sat);
    
    clear arm;
    arm(1) = left_arm;
    arm(2) = right_arm;

    % Base_dia = 0.1;
    % Base_height = 0.00;
    arm(1).smiData.RigidTransform(1).angle = 0.0;
    % arm(1).smiData.RigidTransform(1).translation = [Base_height 0 0];
    % arm(1).armAttachOffset(1).orientation = [45 0 90]*dtr;
    % arm(1).armAttachOffset(1).orientation = [0 -135 0]*dtr;
    % arm(1).armAttachOffset(1).translation = [ 1*((sat.service.radius)*cos(pi/8)*(1-cos(pi/4)))+Base_height*cos(pi/4) -Base_dia/2 (sat.service.radius)*cos(pi/8)*cos(pi/4)+Base_height*cos(pi/4)];

    arm(2).smiData.RigidTransform(1).angle = 0.0;
    % arm(2).armAttachOffset(1).orientation = [-45 0 90]*dtr;
    % arm(2).armAttachOffset(1).orientation = [0 -45 0]*dtr;
    % arm(2).armAttachOffset(1).translation = [ -1*((sat.service.radius)*cos(pi/8)*(1-cos(pi/4)))+Base_height*cos(pi/4) -Base_dia/2 (sat.service.radius)*cos(pi/8)*cos(pi/4)-Base_height*cos(pi/4)];

else
    % Initial Joint Angles and Rates
    for i = 1:nLink
        q(i) = arm(1).smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end
    arm_data = configure3DOFArm(arm(1),q,sat);
    clear arm;
    arm(1) = arm_data;
    arm(2).nLink = 0;

end
% Workspace cleanup
clear q qDot inertiaMatBase inertiaMat mt massVec

% Call forward kinematics to compute pose matrices (relative to spacecraft)
PoseMats = fKinematics(arm(1).DHparams,'all');

Base_a = sat.service.radius; % This should be the base of the arm
Base_b = sat.service.radius;
Base_c = sat.service.length;

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


% Compute initial geometry
%Rot_Inertial_To_SC = robotZRot(psi)*robotYRot(theta)*robotXRot(phi);
% Rot_Inertial_To_SC = robotXRot(phi)*robotZRot(psi)*robotYRot(theta);
% Tmat(1,:,:) = [ [Rot_Inertial_To_SC(1:3,1:3) [0 0 0]']; [0 0 0 1] ];
% T10 = [PoseMats(1:3,1:3,1) PoseMats(1:3,4,1); [0 0 0 1] ];
% T20 = [PoseMats(1:3,1:3,2) PoseMats(1:3,4,2); [0 0 0 1] ];
% T30 = [PoseMats(1:3,1:3,3) PoseMats(1:3,4,3); [0 0 0 1] ];
% T40 = [PoseMats(1:3,1:3,4) PoseMats(1:3,4,4); [0 0 0 1] ];
% 
% rBase = rBase0';

busInfo = Simulink.Bus.createObject(jointControlData);
jointControlDataBus = evalin('base',busInfo.busName);
%% Satellite Control Calculations
% This is a relative position and velocity to the client
satControlData_Trans.cmdPos = -1*[sat.service.IC.pose.position.x sat.service.IC.pose.position.y sat.service.IC.pose.position.z];

% Create Simulink Bus
busInfo = Simulink.Bus.createObject(satControlData_Trans);
satControlDataBus_Trans = evalin('base',busInfo.busName);
busInfo = Simulink.Bus.createObject(satControlData_Rot);
satControlDataBus_Rot = evalin('base',busInfo.busName);
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'Trans';
elems(1).Dimensions = [1];
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'satControlDataBus_Trans';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real';
elems(2) = Simulink.BusElement;
elems(2).Name = 'Rot';
elems(2).Dimensions = [1];
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'satControlDataBus_Rot';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real';
satControlDataBus = Simulink.Bus;
satControlDataBus.Elements = elems;

