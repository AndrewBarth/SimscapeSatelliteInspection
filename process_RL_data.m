
% Define the run to be loaded
runDate = '2023-10-20';
runTime = '08-52';

episode = 1000;

[agentData,prescribed_jointAngles] = loadRLCase(runDate,runTime,episode);