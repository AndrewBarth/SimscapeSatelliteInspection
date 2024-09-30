clear
%clc

MISSION_TYPE = 0;
VSS_RoboticArmOperation = Simulink.Variant('MISSION_TYPE==0');
VSS_CubeSatOperation = Simulink.Variant('MISSION_TYPE==1');



% Select robotic arm to use in the simulation
ARM_TYPE = 0;    
% 0 = Planar3Link
% 1 = ViperX300 (5-DOF)
% 2 = General6DOF (6-DOF)
% 3 = General7DOF (7-DOF)
% 4 = Planar2Link
% 5 = Dual Arm (Both 7-DOF)
% 6 = Dual Arm (Both 3-DOF)

VSS_RoboticArmPlanar3Link = Simulink.Variant('ARM_TYPE==0');
VSS_RoboticArmViperX300   = Simulink.Variant('ARM_TYPE==1');
VSS_RoboticArmGeneral6DOF = Simulink.Variant('ARM_TYPE==2');
VSS_RoboticArmGeneral7DOF = Simulink.Variant('ARM_TYPE==3');
VSS_RoboticArmPlanar2Link = Simulink.Variant('ARM_TYPE==4');
VSS_RoboticArmDualArm7DOF = Simulink.Variant('ARM_TYPE==5');
VSS_RoboticArmDualArm3DOF = Simulink.Variant('ARM_TYPE==6');

% Define path for required files
addpath('RoboticArm_Models')
addpath('RoboticArm_Models/ViperX_300');
addpath('RoboticArm_Models/General_6DOF_Arm');
addpath('RoboticArm_Models/General_7DOF_Arm');
addpath('RoboticArm_Models/Planar_3Link_Arm');
addpath('RoboticArm_Models/Planar_2Link_Arm');
addpath('Utilities');
addpath('GNC')
addpath('ClientSatellite');
addpath('ServicingSatellite');
addpath('ServicingSatellite/Camera');
addpath('FlexibleBeam');
addpath('ManipulatorControl');
addpath('TestScenarios')
addpath('TestScenarios/TwoLinkTest/')
addpath('DataProcessingScripts')


% Load parameter data for each element
if ARM_TYPE == 1
    ViperX_300_DataFile
elseif ARM_TYPE == 2
    General_6DOF_ArmAssembly_DataFile
elseif ARM_TYPE == 3
    General_7DOF_ArmAssembly_DataFile
    arm(1).smiData = smiData; clear smiData
elseif ARM_TYPE == 4
    ArmAssembly_DataFile
    RigidBodyTree = load("2linkPlanarTree.mat");

    arm(1).smiData = smiData;
    arm(2).smiData = smiData; clear smiData
elseif ARM_TYPE == 5

    General_7DOF_ArmAssembly_DataFile
    arm(1).smiData = smiData; clear smiData
    arm(1).rigidBodyTree = load("General7DOF_RigidBodyTree.mat");
    i=0;
    for t=0:.001:49
        i=i+1;
        a(i) = 0.00088;
        v(i) = a(i)*t;
        ang(i) = 0.5*a(i)*t^2;
    end
   tVec=0:.001:49;
   zeroVec=zeros(1,length(tVec));

   angles=[zeroVec;ang;zeroVec;zeroVec;zeroVec;zeroVec;zeroVec;];
   rates=[zeroVec;v;zeroVec;zeroVec;zeroVec;zeroVec;zeroVec;];
   % times = [0 49];
   prescribed_jointAngles = timeseries(angles,tVec);
   prescribed_jointRates = timeseries(rates,tVec);

   General_7DOF_ArmAssembly_DataFile
   arm(2).smiData = smiData; clear smiData
   arm(2).rigidBodyTree = load("General7DOF_RigidBodyTree.mat");

elseif ARM_TYPE == 6

    % Set up arm 1
    ArmAssembly_DataFile
    arm(1).smiData = smiData; clear smiData
    arm(1).rigidBodyTree = load("3linkPlanarTree.mat");

   % Set up arm 2
   ArmAssembly_DataFile
   arm(2).smiData = smiData; clear smiData
   arm(2).rigidBodyTree = load("3linkPlanarTree.mat");

else
    ArmAssembly_DataFile
    arm(1).smiData = smiData; clear smiData
    RigidBodyTree = load("3linkPlanarTree.mat");
end

ClientAssembly_DataFile
AllParams

% Load parameter override data from TestScenarios directory
if ARM_TYPE == 1
    ViperX_300_test
elseif ARM_TYPE == 2
    General6DOF_test
elseif ARM_TYPE == 3
    General7DOF_test
elseif ARM_TYPE == 5
    General7DOF_test
elseif ARM_TYPE == 6
    Dual3LinkTest
end


ARM_CONTROL_TYPE = 0;
VSS_NoControl = Simulink.Variant('ARM_CONTROL_TYPE==0');
VSS_ModelBasedArmControl = Simulink.Variant('ARM_CONTROL_TYPE==1');
VSS_RLBasedArmControl = Simulink.Variant('ARM_CONTROL_TYPE==2');
VSS_DualArmStabilization = Simulink.Variant('ARM_CONTROL_TYPE==3');

% Perfom initialization calculations based on parameter data
AllCalcs
loadBusData

% Set the source of the joint commands (computed or playback)
JOINT_COMMAND_SOURCE = 1;
VSS_ComputedTorques = Simulink.Variant('JOINT_COMMAND_SOURCE==0');
VSS_Playback         = Simulink.Variant('JOINT_COMMAND_SOURCE==1');

% Load the Simulink model
load_system('SatelliteServicing_Mission.slx');

% Call routine to configure the joints in the arm model to accept the
% chosen joint command type (only set up for planar 3 Link arm and Dual Arms)
% Used for playback mode
if (ARM_TYPE == 0 || ARM_TYPE == 5 || ARM_TYPE == 6) && MISSION_TYPE == 0
   configureArmJoints
end

% The robotTree is used when inverse kinematic blocks are not commented out
%robotTree=importrobot('SatelliteServicing_Mission','ConvertJoints','convert-to-fixed');