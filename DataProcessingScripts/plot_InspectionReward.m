
episode_step = 10;

for i = 1:length(agentData)
    rewards = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.reward;
    nAgents = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.nAgents;
    facesCovered = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.nInspected;
    inspectionTime = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.sim_time;
    fov = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.fov*180/pi;
    ref_period = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.orbit(:,2);
    sma = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.orbit(:,3);
    inc = agentData{i}.(extractBefore(agentFileName,'.mat')).cubesat.orbit(:,4)*180/pi;

    episode(i) = episode_step*i - episode_step;

    total_reward = sum(rewards,2);
    mean_reward(i) = mean(total_reward);
    min_reward(i) = min(total_reward);
    max_reward(i) = max(total_reward);

    mean_agents(i) = mean(nAgents);
    mean_faces(i) = mean(facesCovered);
    mean_fov(i) = mean(fov);
    mean_sma(i) = mean(sma);
    mean_inc(i) = mean(inc);
    mean_time(i) = mean(inspectionTime);
    mean_ref_period(i) = mean(ref_period);
end
figure;plot(episode,mean_reward);hold all
plot(episode,max_reward)
plot(episode,min_reward)
legend('Mean','Max','Min')
title('Total Reward');ylabel('Reward');xlabel('Episode');grid on; grid minor

figure;plot(episode,mean_agents)
title('Number of Agents');ylabel('Number of Agents');xlabel('Episode');grid on; grid minor
figure;plot(episode,mean_faces)
title('Number of Faces Covered');ylabel('Faces');xlabel('Episode');grid on; grid minor
figure;plot(episode,mean_fov)
title('Camera Field of View');ylabel('Field of View (deg)');xlabel('Episode');grid on; grid minor
figure;plot(episode,mean_time./mean_ref_period*100)
title('Time of Inspection as a Percentage of Orbital Period');ylabel('Percent');xlabel('Episode');grid on; grid minor
% figure;plot(episode,mean_ref_period)
% title('Period of Reference Orbit');ylabel('Period (s)');xlabel('Episode');grid on; grid minor
