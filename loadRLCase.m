function [agentData,prescribed_jointAngles] = loadRLCase(runDate,runTime,episode)

% Form the path to the data files
agent = '1';
dataDir = '\\wsl.localhost\Ubuntu-20.04\home\barthal\SimscapeSatelliteInspection\data_storage';
filePath = append(dataDir,'\',runDate,'-',runTime,'\',num2str(agent),'_',num2str(episode),'\');

% Form the full path for the data files
agentFileName = 'agent_parameters.mat';
agentFile = append(filePath,agentFileName);

% Load the data
agentData = load(agentFile);

% Put the joint angles into a timeseries variable
prescribed_jointAngles=timeseries(agentData.agent_parameters.arm.jAngle,agentData.agent_parameters.time);
