clear
clc

% Select robotic arm to use in the simulation
ARM_TYPE = 0;    
% 0 = Planar3Link
% 1 = ViperX300 (5-DOF)
% 2 = General6DOF (6-DOF)

VSS_RoboticArmPlanar3Link = Simulink.Variant('ARM_TYPE==0');
VSS_RoboticArmViperX300   = Simulink.Variant('ARM_TYPE==1');
VSS_RoboticArmGeneral6DOF = Simulink.Variant('ARM_TYPE==2');

% Define path for required files
addpath('ViperX_300');
addpath('General_6DOF_Arm');
addpath('Planar_3Link_Arm');
addpath('Utilities');
addpath('GNC')
addpath('Planar_3Link_Arm');
addpath('ClientSatellite');
addpath('FlexibleBeam');
addpath('Camera');
addpath('ManipulatorControl');
addpath('TestScenarios')


% Load parameter data for each element
if ARM_TYPE == 1
    ViperX_300_DataFile
elseif ARM_TYPE == 2
    General_6DOF_ArmAssembly_DataFile
else
    ArmAssembly_DataFile
end

ClientAssembly_DataFile
AllParams

% Load parameter override data from TestScenarios directory


% Perfom initialization calculations based on parameter data
AllCalcs
loadBusData
