
% Define the run to be loaded
runDate = '2023-06-29';
runTime = '10-24';

% Form the path to the data files
agent = '1';
episode = '1';
dataDir = '\\wsl.localhost\Ubuntu-20.04\home\barthal\SimscapeSatelliteInspection\data_storage';
filePath = append(dataDir,'\',runDate,'-',runTime,'\',agent,'_',episode,'\');

% Form the full path for the data files
agentFileName = 'Test_Scenario.mat';
agentFile = append(filePath,agentFileName);

% Clean up workspace
clear agent episode dataDir filePath agentFileName

% Load the data
agentData = load(agentFile);

% Put the joint angles into a timeseries variable
prescribed_jointAngles=timeseries(agentData.Test_Scenario.arm.jAngle,agentData.Test_Scenario.time);
