clear
%clc

%% Define top-level configuration settings
MISSION_TYPE = 0;
VSS_RoboticArmOperation = Simulink.Variant('MISSION_TYPE==0');
VSS_CubeSatOperation = Simulink.Variant('MISSION_TYPE==1');

% Select robotic arm to use in the simulation
ARM_TYPE = 6;    
% 0 = Planar3Link
% 1 = ViperX300 (5-DOF)
% 2 = General6DOF (6-DOF)
% 3 = General7DOF (7-DOF)
% 4 = Planar2Link
% 5 = Dual Arm (Both 7-DOF)
% 6 = Dual Arm (Both 3-DOF)

% Select the control type for each arm
ARM1_CONTROL_TYPE = 4;
ARM2_CONTROL_TYPE = 3;
% 0: No Control (zero torque cmds)
% 1: Moded Based Control
% 2: RL Based Control
% 3: Dual Arm Stabilization (only valid for second arm in dual arm cases)
% 4: Playback of joint angles

%% Path settings
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

% Load default parameter data for each element
AllParams

%% Load Test scenario (used to override the default parameters)
% Load parameter override data from TestScenarios directory
if ARM_TYPE == 1
    ViperX_300_test
elseif ARM_TYPE == 2
    General6DOF_test
elseif ARM_TYPE == 3
    General7DOF_test
elseif ARM_TYPE == 4
    % Dual2LinkTest
elseif ARM_TYPE == 5
    General7DOF_test
elseif ARM_TYPE == 6
    Dual3LinkTest
else
    Single3LinkTest
end

% Perfom initialization calculations based on parameter data
AllCalcs
loadBusData

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