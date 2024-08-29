
totalFaces = 122; % G(2,2)
totalFaces = 272; % G(3,3)
rtd = 180/pi;

for i = 1:length(agentData)
    agents(i) = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.nAgents(end);
    nInspected(i) = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.nInspected(end);
    sim_time(i) = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.sim_time(end);
    ref_period(i) = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.orbit(end,2);
    orbit_sma(i) = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.orbit(end,3);
    orbit_inc(i) = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.orbit(end,4);
    dep_fov(i) = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.fov(end)*rtd;

    if ~isempty(agentData2{i})
        orbit2_sma(i) = agentData2{i}.(extractBefore(agentFileName,'.mat')).cubesat.orbit(end,3);
        orbit2_inc(i) = agentData2{i}.(extractBefore(agentFileName,'.mat')).cubesat.orbit(end,4);
        dep2_fov(i) = agentData2{i}.(extractBefore(agentFileName,'.mat')).cubesat.fov(end)*rtd;
    else
        orbit2_sma(i) = orbit2_sma(i-1);
        orbit2_inc(i) = orbit2_inc(i-1);
        dep2_fov(i)   = dep2_fov(i-1);
    end
end

figure;
tiledlayout(2,2)
nexttile
plot(sortedEpisodes,agents)
xlabel({'Episode';'(a)'});ylabel('Number of Deputies');title('Number of Deputies Selected for Inspection Task')
axis([-Inf Inf 0 5])
grid on;
nexttile
plot(sortedEpisodes,nInspected)
xlabel({'Episode';'(b)'});ylabel('Faces Inspected');title("Number of Faces Inspected (of" + totalFaces + ")")
axis([min(sortedEpisodes) max(sortedEpisodes) round(0.9*min(nInspected)) round(totalFaces*1.1)])
% axis([-Inf Inf 241 299])
grid on;grid minor
nexttile([1 2])
plot(sortedEpisodes,sim_time./ref_period)
xlabel({'Episode';'(c)'});ylabel('Percentage');title('Percentage of Orbital Period Used for Inspection')
axis([-Inf Inf 0.5 1])
grid on;grid minor

figure;
tiledlayout(2,2)
nexttile
plot(sortedEpisodes,orbit_sma); hold all
plot(sortedEpisodes,orbit2_sma)
xlabel({'Episode';'(a)'});ylabel('Semi-Major Axis (m)');title('Semi-Major Axis for Each Deputy')
legend('Deputy 1','Deputy 2')
grid on;
nexttile
plot(sortedEpisodes,orbit_inc); hold all
plot(sortedEpisodes,orbit2_inc)
xlabel({'Episode';'(b)'});ylabel('Inclination (deg)');title('Inclination for Each Deputy')
legend('Deputy 1','Deputy 2')
grid on;grid minor
nexttile([1 2])
plot(sortedEpisodes,dep_fov); hold all
plot(sortedEpisodes,dep2_fov)
xlabel({'Episode';'(c)'});ylabel('Field Of View (deg)');title('Field Of View for Each Deputy')
legend('Deputy 1','Deputy 2')
grid on;grid minor
