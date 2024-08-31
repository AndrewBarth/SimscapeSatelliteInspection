totalFaces = 32; % G(1,1)
% totalFaces = 122; % G(2,2)
% totalFaces = 272; % G(3,3)
rtd = 180/pi;

% runType = 'Eval';
% agentFileName = ['Benchmark2_RL_',runType,'.mat'];

for i = 1:length(agentData_2m)
    dep_fov_2m(i) = agentData_2m{i}.(extractBefore(agentFileName_2m,'.mat')).cubesat.fov(end)*rtd;

    if ~isempty(agentData2_2m{i})
        dep2_fov_2m(i) = agentData2_2m{i}.(extractBefore(agentFileName_2m,'.mat')).cubesat.fov(end)*rtd;
    else
        dep2_fov_2m(i)   = dep2_fov_2m(i-1);
    end
end

for i = 1:length(agentData_5m)
    dep_fov_5m(i) = agentData_5m{i}.(extractBefore(agentFileName_5m,'.mat')).cubesat.fov(end)*rtd;

    if ~isempty(agentData2_5m{i})
        dep2_fov_5m(i) = agentData2_5m{i}.(extractBefore(agentFileName_5m,'.mat')).cubesat.fov(end)*rtd;
    else
        dep2_fov_5m(i)   = dep2_fov_5m(i-1);
    end
end

figure;
tiledlayout(2,1)
nexttile
plot(sortedEpisodes_2m,dep_fov_2m); hold all
plot(sortedEpisodes_2m,dep2_fov_2m)
xlabel({'Episode';'(c)'});ylabel('Field Of View (deg)');title('Field Of View for Each Deputy: 2m Polyhedron Radius')
legend('Deputy 1','Deputy 2')
grid on;grid minor
nexttile
plot(sortedEpisodes_5m,dep_fov_5m); hold all
plot(sortedEpisodes_5m,dep2_fov_5m)
xlabel({'Episode';'(c)'});ylabel('Field Of View (deg)');title('Field Of View for Each Deputy: 5m Polyhedron Radius')
legend('Deputy 1','Deputy 2')
grid on;grid minor