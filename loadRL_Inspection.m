
% Define the run to be loaded

% % runDate = '2024-08-27';
% % runTime = '07-50';        % Training 200 cases G(2,2) polyhedron
% % runType = 'Train';

% % runDate = '2024-08-27';
% % runTime = '13-14';        % Training 200 cases G(3,3) polyhedron
% % runType = 'Train';

% % runDate = '2024-08-28';
% % runTime = '12-16';        % Evaluation of the 08-27-07-50 training
% % runType = 'Eval';

runDate = '2024-08-29';
runTime = '10-54';        % Evaluation of the 08-27-13-14 training
runType = 'Eval';

% Set the storage location
dataDir = 'data_storage';
baseFilePath = append(dataDir,'\',runDate,'-',runTime,'\');

% Examine all subdirectories
allDirs = dir(baseFilePath);

nDirs = 0;
dirList = {};
episodes = 0;
for i=1:length(allDirs)
    % Look at agent 1 subdirectories to determine how many episodes are 
    % in this directory
    if strfind(allDirs(i).name,'1_')
        nDirs = nDirs + 1;
        dirList{end+1} = allDirs(i).name;
        episodes(nDirs) = str2num(extractAfter(allDirs(i).name,'1_'));
    end
end

% Sort the episode directory list numerically
[sortedEpisodes, sortIdx] = sort(episodes);
sortedDirList = dirList(sortIdx);
   

% Load the data for agent 1
agentData = {};
agentFileName = ['Benchmark2_RL_',runType,'.mat'];

agentData2 = {};
agentData3 = {};
agentData4 = {};
for i=1:length(dirList)
    
    filePath = append(baseFilePath,sortedDirList{i},'\');
    agentFile = append(filePath,agentFileName);

    % Load the data
    agentData{end+1} = load(agentFile);
    % nAgents(i) = agentData{end}.(extractBefore(agentFileName,'.mat')).cubesat.nAgents(end);
    nAgents(i) = agentData{end}.(extractBefore(agentFileName,'.mat')).cubesat.nAgents(1);

    % Training data does not have a uniform number of agentsso only bring in additional agents for eval scenarios
    if strcmp(runType,'Eval')
        if nAgents(i) >= 2
            filePath = append(baseFilePath,strrep(sortedDirList{i},'1_','2_'),'\');
            agentFile = append(filePath,agentFileName);
            agentData2{end+1} = load(agentFile);
        else
            agentData2{end+1} = []; 
        end
        if nAgents(i) >= 3
            filePath = append(baseFilePath,strrep(sortedDirList{i},'1_','3_'),'\');
            agentFile = append(filePath,agentFileName);
            agentData3{end+1} = load(agentFile);
        else
            agentData3{end+1} = []; 
        end
        if nAgents(i) >= 4
            filePath = append(baseFilePath,strrep(sortedDirList{i},'1_','4_'),'\');
            agentFile = append(filePath,agentFileName);
            agentData4{end+1} = load(agentFile);
        else
            agentData4{end+1} = []; 
        end
    end
end


clear dataDir baseFilePath filePath dirList sortedDirList episodes agentFile i 