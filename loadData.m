

% Define path for required file
addpath('Utilities');
addpath('Planar_3Link_Arm');
addpath('ClientSatellite');
addpath('FlexibleBeam');
addpath('Camera');
addpath('ManipulatorControl');

% Load parameter data for each element
ArmAssembly_DataFile
FlexibleRod_Params
ClientAssembly_DataFile
Satellite_Params
Initialize_Joint_Control
Initialize_Sat_Control
Initialize_Navigation
loadBusData



