function [agentData,prescribed_jointAngles] = loadRLCase(runDate,runTime,episode)

% Form the path to the data files
agent = '1';
% dataDir = '\\wsl.localhost\Ubuntu-20.04\home\barthal\SimscapeSatelliteInspection\data_storage';
dataDir = 'data_storage';

%filePath = '';
filePath = append(dataDir,'\',runDate,'-',runTime,'\',num2str(agent),'_',num2str(episode),'\');
% Form the full path for the data files
%agentFileName = 'agent_parameters.mat';
% agentFileName = 'Benchmark2_RL_Eval.mat';
agentFileName = 'Single_Arm_RoboticsEval.mat';
% agentFileName = 'Single_Arm_RoboticsTrain.mat';
agentFile = append(filePath,agentFileName);

% Load the data
agentData = load(agentFile);

% Put the joint angles into a timeseries variable
prescribed_jointAngles=timeseries(agentData.Single_Arm_RoboticsEval.arm.jAngle,agentData.Single_Arm_RoboticsEval.time);
% prescribed_jointAngles=timeseries(agentData.Single_Arm_RoboticsTrain.arm.jAngle,agentData.Single_Arm_RoboticsTrain.time);
% prescribed_jointAngles = 0;