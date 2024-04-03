
% Define the run to be loaded
runDate = '2024-03-05';
runTime = '15-09';

episode = 1;

[agentData,prescribed_jointAngles] = loadRLCase(runDate,runTime,episode);