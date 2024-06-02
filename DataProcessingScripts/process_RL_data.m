
% Define the run to be loaded
runDate = '2024-05-25';
runTime = '21-16';

episode = 1;

[agentData,prescribed_jointAngles] = loadRLCase(runDate,runTime,episode);