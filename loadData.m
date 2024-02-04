clear
clc

% Select robotic arm to use in the simulation
ARM_TYPE = 0;    
% 0 = Planar3Link
% 1 = ViperX300 (5-DOF)
% 2 = General6DOF (6-DOF)
% 3 = General7DOF (7-DOF)

VSS_RoboticArmPlanar3Link = Simulink.Variant('ARM_TYPE==0');
VSS_RoboticArmViperX300   = Simulink.Variant('ARM_TYPE==1');
VSS_RoboticArmGeneral6DOF = Simulink.Variant('ARM_TYPE==2');
VSS_RoboticArmGeneral7DOF = Simulink.Variant('ARM_TYPE==3');

% Define path for required files
addpath('RoboticArm_Models')
addpath('RoboticArm_Models/ViperX_300');
addpath('RoboticArm_Models/General_6DOF_Arm');
addpath('RoboticArm_Models/General_7DOF_Arm');
addpath('RoboticArm_Models/Planar_3Link_Arm');
addpath('Utilities');
addpath('GNC')
addpath('ClientSatellite');
addpath('ServicingSatellite');
addpath('ServicingSatellite/Camera');
addpath('FlexibleBeam');
addpath('ManipulatorControl');
addpath('TestScenarios')
addpath('DataProcessingScripts')


% Load parameter data for each element
if ARM_TYPE == 1
    ViperX_300_DataFile
elseif ARM_TYPE == 2
    General_6DOF_ArmAssembly_DataFile
elseif ARM_TYPE == 3
    General_7DOF_ArmAssembly_DataFile
else
    ArmAssembly_DataFile
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
end

ARM_CONTROL_TYPE = 0;
VSS_ModelBasedArmControl = Simulink.Variant('ARM_CONTROL_TYPE==0');
VSS_RLBasedArmControl = Simulink.Variant('ARM_CONTROL_TYPE==1');

% Perfom initialization calculations based on parameter data
AllCalcs
loadBusData

% Set the source of the joint commands (computed or playback)
JOINT_COMMAND_SOURCE = 0;
VSS_ComputedTorques = Simulink.Variant('JOINT_COMMAND_SOURCE==0');
VSS_Playback         = Simulink.Variant('JOINT_COMMAND_SOURCE==1');

% Call routine to configure the joints in the arm model to accept the
% chosen joint command type (only set up for planar 3 Link arm)
if ARM_TYPE == 0
    configureArmJoints
end

%robotTree=importrobot('SatelliteServicing_Mission','ConvertJoints','convert-to-fixed');