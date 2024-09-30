
% Define the run to be loaded
runDate = '2024-09-28';
runTime = '09-06';          % AI Control same target as training

episode = 1;

[agentData,prescribed_jointAngles] = loadRLCase(runDate,runTime,episode);