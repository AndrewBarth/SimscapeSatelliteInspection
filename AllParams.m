

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
ClientAssembly_DataFile;
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
    ViperX_300_DataFile
    arm(1).smiData = smiData; clear smiData
    nARM = 1;
    ViperX_300_Params;

elseif ARM_TYPE == 2
    % General 6-DOF arm
    General_6DOF_ArmAssembly_DataFile
    arm(1).smiData = smiData; clear smiData
    nARM = 1;
    General_6DOF_Params;

elseif ARM_TYPE == 3
    % General 7-DOF arm
    General_7DOF_ArmAssembly_DataFile
    arm(1).smiData = smiData; clear smiData
    nARM = 1;
    General_7DOF_Params;
    
elseif ARM_TYPE == 4
    % 2-DOF planar arm
    ArmAssembly_DataFile
    RigidBodyTree = load("2linkPlanarTree.mat");

    arm(1).smiData = smiData;
    arm(2).smiData = smiData; clear smiData
    nARM = 1;
    Planar_2DOF_Params;

elseif ARM_TYPE == 5
    % Dual General 7-DOF arms
    % Set up arm 1
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

    % Setup arm 2
    General_7DOF_ArmAssembly_DataFile
    arm(2).smiData = smiData; clear smiData
    arm(2).rigidBodyTree = load("General7DOF_RigidBodyTree.mat");

    nARM = 2;

    DualArm_7DOF_Params;

elseif ARM_TYPE == 6
    % Dual Planar 3-DOF arms
    % Set up arm 1
    ArmAssembly_DataFile
    arm(1).smiData = smiData; clear smiData
    arm(1).rigidBodyTree = load("3linkPlanarTree.mat");

    % Set up arm 2
    ArmAssembly_DataFile
    arm(2).smiData = smiData; clear smiData
    arm(2).rigidBodyTree = load("3linkPlanarTree.mat");

    nARM = 2;
    DualArm_3DOF_Params;
  
else
    % 3-DOF planar arm
    ArmAssembly_DataFile
    arm(1).smiData = smiData; clear smiData
    RigidBodyTree = load("3linkPlanarTree.mat");

    nARM = 1;
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

