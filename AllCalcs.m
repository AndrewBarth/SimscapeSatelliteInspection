%% Rod Calculations
% Call script to load calculations
% flexibleBeam_Calcs;

%% Satellite Calculations
% None were needed for this method

%% Arm and Joint Control Calculations
% Define variables for variant control subsystems
VSS_RoboticArmPlanar3Link = Simulink.Variant('ARM_TYPE==0');
VSS_RoboticArmViperX300   = Simulink.Variant('ARM_TYPE==1');
VSS_RoboticArmGeneral6DOF = Simulink.Variant('ARM_TYPE==2');
VSS_RoboticArmGeneral7DOF = Simulink.Variant('ARM_TYPE==3');
VSS_RoboticArmPlanar2Link = Simulink.Variant('ARM_TYPE==4');
VSS_RoboticArmDualArm7DOF = Simulink.Variant('ARM_TYPE==5');
VSS_RoboticArmDualArm3DOF = Simulink.Variant('ARM_TYPE==6');

if ARM_TYPE == 1

    % Initial Joint Angles and Rates
    for i = 1:nLink
        q(i) = arm(1).smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end

    single_arm = configureViperX300Arm(arm(1),q,sat);
    clear arm
    arm(1) = single_arm;

elseif ARM_TYPE == 2
    % Initial Joint Angles and Rates
    for i = 1:nLink
        q(i) = arm(1).smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end
    single_arm = configure6DOFArm(arm(1),q,sat);
    clear arm
    arm(1) = single_arm;

elseif ARM_TYPE == 3
    % Initial Joint Angles and Rates
    for i = 1:nLink
        q(i) = arm(1).smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end

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
        q(i) = arm(1).smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end
    left_arm = configure3DOFArm(arm(1),q,sat);

    % Initial Joint Angles and Rates
    for i = 1:arm(2).nLink
        q(i) = arm(2).smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end
    right_arm = configure3DOFArm(arm(2),q,sat);
    
    clear arm;
    arm(1) = left_arm;
    arm(2) = right_arm;

    arm(1).smiData.RigidTransform(1).angle = 0.0;
    arm(2).smiData.RigidTransform(1).angle = 0.0;

else
    % Initial Joint Angles and Rates
    for i = 1:arm(1).nLink
        q(i) = arm(1).smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end
    arm_data = configure3DOFArm(arm(1),q,sat);
    clear arm;
    arm(1) = arm_data;
    arm(2).nLink = 0;

end
% Workspace cleanup
clear q qDot inertiaMatBase inertiaMat mt massVec DHparams Base_z

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

