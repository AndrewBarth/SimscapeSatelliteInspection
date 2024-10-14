
pos_base = out.base_state.translation.position.Data;
ori_base = out.base_state.rotation.euler.Data;
angv_base = out.base_state.rotation.angular_rate.Data;
data_time = out.base_state.translation.position.Time;


yoffset = 0.0; % 3 link
nVar = 4;  % 2, 3 link
iter = nVar; % 2, 3 link
% nVar = 2;  % 2 link
% iter = 1;  % 2 link

% nVar = 2;      % 7 link
% yoffset = 1.5; % 7 link
% iter = nVar;   % 7 link

nJoints1 = size(out.joint_state1.Data,2)/nVar;
arm1_joint_angles = out.joint_state1.Data(:,1:iter:nVar*nJoints1);
arm1_joint_rates  = out.joint_state1.Data(:,2:iter:nVar*nJoints1);

nJoints2 = size(out.joint_state2.Data,2)/nVar;
arm2_joint_angles = out.joint_state2.Data(:,1:iter:nVar*nJoints2);
arm2_joint_rates  = out.joint_state2.Data(:,2:iter:nVar*nJoints2);
arm2_joint_torques = out.desired_torque1.Data(:,1:nJoints2);
% arm2_joint_torques = squeeze(out.dualArmControlSignal.Data(1,1:nJoints2,:))';

linear_momentum = squeeze(out.momentum_combined.Data(1:3,1,:))';
angular_momentum = squeeze(out.momentum_combined.Data(4:6,1,:))';
linear_momentum2 = squeeze(out.momentum_combined1.Data(1:3,1,:))';
angular_momentum2 = squeeze(out.momentum_combined1.Data(4:6,1,:))';

rtd = 180/pi;

%% Base data
% figure for base positions, individually plotted
% figure;
% subplot(3,1,1)
% plot(data_time,pos_base(:,1)); ylabel('x-Position (m)')
% title('Base Positions')
% legend('Base Position x','location','best')
% grid on; grid minor
% subplot(3,1,2)
% plot(data_time,pos_base(:,2)); ylabel('y-Position (m)')
% legend('Base Position y','location','best')
% grid on; grid minor
% subplot(3,1,3)
% plot(data_time,pos_base(:,3)); ylabel('z-Position (m)')
% legend('Base Position z','location','best')
% grid on; grid minor
% xlabel('Time (s)')

% figure for base orientation, individually plotted
% figure;
% subplot(3,1,1); hold all;
% plot(data_time,ori_base(:,1)*rtd); ylabel('x-Orientation (deg)')
% title('Base Orientation')
% legend('Base Orientation x','location','best')
% grid on; grid minor
% subplot(3,1,2); hold all;
% plot(data_time,ori_base(:,2)*rtd); ylabel('y-Orientation (deg)')
% legend('Base Orientation y','location','best')
% grid on; grid minor
% subplot(3,1,3); hold all;
% plot(data_time,ori_base(:,3)*rtd); ylabel('z-Orientation (deg)')
% legend('Base Orientation z','location','best')
% grid on; grid minor
% xlabel('Time (s)')

% figure for base positions and orientation, co-plotted
figure;
subplot(2,1,1)
plot(data_time,pos_base(:,1)); hold all;
plot(data_time,pos_base(:,2)+yoffset);
plot(data_time,pos_base(:,3));
xlabel('Time (s)'); ylabel('Base Position (m)')
title('Base Positions')
legend('X Axis','Y Axis','Z Axis','location','best')
grid on; grid minor

subplot(2,1,2)
plot(data_time,ori_base(:,1)*rtd); hold all;
plot(data_time,ori_base(:,2)*rtd);
plot(data_time,ori_base(:,3)*rtd);
xlabel('Time (s)'); ylabel('Base Orientation (deg)')
title('Base Orientation')
legend('X Axis','Y Axis','Z Axis','location','best')
grid on; grid minor



%% Joint Data
% figure for joint angles
figure; 
for i=1:nJoints1
    subplot(nJoints1,1,i);
    plot(data_time,arm1_joint_angles(:,i)*180/pi); ylabel('Angle (deg)'); hold all;
    plot(data_time,arm2_joint_angles(:,i)*180/pi);
    legend([['Arm 1 Joint', int2str(i)];['Arm 2 Joint', int2str(i)]],'location','best')
    grid on; grid minor
end
sgtitle('Joint Angles')

% figure for joint rates
figure
for i=1:nJoints1
    subplot(nJoints1,1,i);
    plot(data_time,arm1_joint_rates(:,i)*180/pi); ylabel('Rate (deg/s)'); hold all;
    plot(data_time,arm2_joint_rates(:,i)*180/pi);
    legend([['Arm 1 Joint', int2str(i)];['Arm 2 Joint', int2str(i)]],'location','best')
    grid on; grid minor
end
sgtitle('Joint Rates')


% figure for desired joint torque
figure
for i=1:nJoints2
    subplot(nJoints2,1,i);
    % plot(data_time,arm2_joint_torques(i,:)); ylabel('Joint Torque (Nm)'); hold all;
    plot(data_time,arm2_joint_torques(:,i)); ylabel('Joint Torque (Nm)'); hold all;
    legend(['Arm 1 Joint', int2str(i)],'location','best')
    grid on; grid minor
end
sgtitle('Desired Joint Torques')
%% Momentum 
% Individual plots
% figure;
% subplot(3,1,1)
% plot(data_time,linear_momentum(:,1)); ylabel('x-Momentum (Ns)')
% title('Linear Momentum')
% legend('Linear Momentum x','location','best')
% grid on; grid minor
% subplot(3,1,2)
% plot(data_time,linear_momentum(:,2)); ylabel('y-Momentum (Ns)')
% legend('Linear Momentum y','location','best')
% grid on; grid minor
% subplot(3,1,3)
% plot(data_time,linear_momentum(:,3)); ylabel('z-Momentum (Ns)')
% legend('Linear Momentum z','location','best')
% grid on; grid minor
% xlabel('Time (s)')

% figure;
% subplot(3,1,1)
% plot(data_time,angular_momentum(:,1)); ylabel('x-Momentum (Nms)')
% title('Angular Momentum')
% legend('Angular Momentum x','location','best')
% grid on; grid minor
% subplot(3,1,2)
% plot(data_time,angular_momentum(:,2)); ylabel('y-Momentum (Nms)')
% legend('Angular Momentum y','location','best')
% grid on; grid minor
% subplot(3,1,3)
% plot(data_time,angular_momentum(:,3)); ylabel('z-Momentum (Nms)')
% legend('Angular Momentum z','location','best')
% grid on; grid minor
% xlabel('Time (s)')

% Combined plots
figure;
subplot(2,1,1)
plot(data_time,linear_momentum(:,1)); hold all
plot(data_time,linear_momentum(:,2)); 
plot(data_time,linear_momentum(:,3)); 
ylabel('Linear Momentum (Ns)'); 
xlabel('Time (s)')
title('Linear Momentum')
legend('X Axis','Y Axis','Z Axis','location','best')
grid on; grid minor
subplot(2,1,2)
plot(data_time,angular_momentum(:,1)); hold all
plot(data_time,angular_momentum(:,2)); 
plot(data_time,angular_momentum(:,3)); 
ylabel('Angular Momentum (Nms)'); 
xlabel('Time (s)')
title('Angular Momentum')
legend('X Axis','Y Axis','Z Axis','location','best')
grid on; grid minor

figure;
subplot(2,1,1)
plot(data_time,linear_momentum2(:,1)); hold all
plot(data_time,linear_momentum2(:,2)); 
plot(data_time,linear_momentum2(:,3)); 
ylabel('Linear Momentum (Ns)'); 
xlabel('Time (s)')
title('Linear Momentum2')
legend('X Axis','Y Axis','Z Axis','location','best')
grid on; grid minor
subplot(2,1,2)
plot(data_time,angular_momentum2(:,1)); hold all
plot(data_time,angular_momentum2(:,2)); 
plot(data_time,angular_momentum2(:,3)); 
ylabel('Angular Momentum (Nms)'); 
xlabel('Time (s)')
title('Angular Momentum2')
legend('X Axis','Y Axis','Z Axis','location','best')
grid on; grid minor