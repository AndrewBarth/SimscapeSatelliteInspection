
% Define the run to be loaded
runDate = '2023-07-14';
runTime = '08-11';

episode = 90;

[agentData,prescribed_jointAngles] = loadRLCase(runDate,runTime,episode);