
% Define the run to be loaded
runDate = '2024-05-16';
runTime = '11-38';

episode = 1;

[agentData,prescribed_jointAngles] = loadRLCase(runDate,runTime,episode);