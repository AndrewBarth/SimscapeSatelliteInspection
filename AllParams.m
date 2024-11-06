

%% General parameters

% Set the run time and step size of the simulation
if MISSION_TYPE == 0
    endTime = 99;
    endTime = 49;
    stepSize = 0.001;
elseif MISSION_TYPE == 1
    stepSize = 0.5;
    
    % Inspection Parameters
    loadInspectionParams
    loadCubesatParams
end

%% Rod Parameters
% Call script to load default parameters
% flexibleBeam_Params;

%% Satellite Parameters
% Call script to load default parameters
ServicingSatellite_Params;

% Setup client state
% Call script to load default parameters
Client_Params;

%% Robotic Arm Parameters

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

% Call script to load default parameters
if ARM_TYPE == 1
    % Viper X 300 Arm
    ViperX_300_Params;

elseif ARM_TYPE == 2
    % General 6-DOF arm
    General_6DOF_Params;

elseif ARM_TYPE == 3
    % General 7-DOF arm
    General_7DOF_Params;
    
elseif ARM_TYPE == 4
    % 2-DOF planar arm
    Planar_2DOF_Params;

elseif ARM_TYPE == 5
    % Dual General 7-DOF arms
    DualArm_7DOF_Params;

elseif ARM_TYPE == 6
    % Dual Planar 3-DOF arms
    DualArm_3DOF_Params;
  
else
    % 3-DOF planar arm
    Planar_3DOF_Params;
  
end

% Set the number of actions to the number of links in the primary arm
nAction = arm(1).nLink;

nLink = NLINKS.Value;

%% Joint Control Parameters
% Script to define parameters used in the joint control algorithm.
JointControl_Params;


%% Satellite Control Parameters
ServicingSatellite_Control_Params;

%% Navigation Parameters
nav.CameraToBase.orientation = [-90 0 -45]*dtr;

