time = out.cubesatRelState.Cubesat1_RelState.Rel_Position.Time;

cubesatRelState{1} = out.cubesatRelState.Cubesat1_RelState;
cubesatRelState{2} = out.cubesatRelState.Cubesat2_RelState;
cubesatRelState{3} = out.cubesatRelState.Cubesat3_RelState;
cubesatRelState{4} = out.cubesatRelState.Cubesat4_RelState;

figure; 
    C=colororder;
    plot3(0,0,0,'k*');
    hold all
    lText{1} = 'Target';
    for i = 1:nsat
        plot3(cubesatRelState{i}.Rel_Position.Data(:,1),cubesatRelState{i}.Rel_Position.Data(:,2),cubesatRelState{i}.Rel_Position.Data(:,3),'color',C(i,:))
        lText{i+1} = strcat('Cubesat',num2str(i));
    end    
    title('Cubesat Relative Positions')
    xlabel('X (m)'),ylabel('Y (m)'),zlabel('Z (m)')
    legend(lText,'Location','NorthEast')


figure; hold all;
    lText = {};
    for i = 1:nsat
        subplot(3,1,1); plot(time,cubesatRelState{i}.Rel_Position.Data(:,1),'color',C(i,:)); hold all
        subplot(3,1,2); plot(time,cubesatRelState{i}.Rel_Position.Data(:,2),'color',C(i,:)); hold all
        subplot(3,1,3); plot(time,cubesatRelState{i}.Rel_Position.Data(:,3),'color',C(i,:)); hold all
        lText{i} = strcat('Cubesat',num2str(i));
    end
    subplot(3,1,1); legend(lText); title('X Relative Position'); xlabel('Time (s)'); ylabel('Position (m)');
    subplot(3,1,2); legend(lText); title('Y Relative Position'); xlabel('Time (s)'); ylabel('Position (m)');
    subplot(3,1,3); legend(lText); title('Z Relative Position'); xlabel('Time (s)'); ylabel('Position (m)');
    sgtitle('Cubesat Relative Position')

figure; hold all;
    lText = {};
    for i = 1:nsat
        subplot(3,1,1); plot(time,cubesatRelState{i}.Rel_Velocity.Data(:,1),'color',C(i,:)); hold all
        subplot(3,1,2); plot(time,cubesatRelState{i}.Rel_Velocity.Data(:,2),'color',C(i,:)); hold all
        subplot(3,1,3); plot(time,cubesatRelState{i}.Rel_Velocity.Data(:,3),'color',C(i,:)); hold all
        lText{i} = strcat('Cubesat',num2str(i));
    end
    subplot(3,1,1); legend(lText); title('X Relative Velocity'); xlabel('Time (s)'); ylabel('Velocity (m)');
    subplot(3,1,2); legend(lText); title('Y Relative Velocity'); xlabel('Time (s)'); ylabel('Velocity (m)');
    subplot(3,1,3); legend(lText); title('Z Relative Velocity'); xlabel('Time (s)'); ylabel('Velocity (m)');
    sgtitle('Cubesat Relative Velocity')