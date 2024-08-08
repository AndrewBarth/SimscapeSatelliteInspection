%% ALWAYS RUN THIS SECTION AS A FIRST STEP (YOU ONLY NEED TO DO IT ONCE)
close all
jointData = [out.joint_state.Data out.joint_cmds.Data];
data_time = (0:endTime/(length(jointData)-1):endTime)';
rtd = 180/pi;

%% Joint Data
% figure for joint angles
figure; 
subplot(3,1,1)
plot(data_time,jointData(:,1)*180/pi); ylabel('Angle (deg)')
title('Joint Angles')
legend('Joint 1','location','best')
grid on; grid minor
subplot(3,1,2)
plot(data_time,jointData(:,5)*180/pi); ylabel('Angle (deg)')
legend('Joint 2','location','best')
grid on; grid minor
subplot(3,1,3)
plot(data_time,jointData(:,9)*180/pi); ylabel('Angle (deg)')
legend('Joint 3','location','best')
grid on; grid minor
xlabel('Time (s)')

% figure for joint angle rates
figure; 
subplot(3,1,1)
plot(data_time,jointData(:,2)*180/pi); ylabel('Angle Rate (deg/s)')
title('Joint Angle Rate')
legend('Joint 1','location','best')
grid on; grid minor
subplot(3,1,2)
plot(data_time,jointData(:,6)*180/pi); ylabel('Angle Rate (deg/s)')
legend('Joint 2','location','best')
grid on; grid minor
subplot(3,1,3)
plot(data_time,jointData(:,10)*180/pi); ylabel('Angle Rate (deg/s)')
legend('Joint 3','location','best')
grid on; grid minor
xlabel('Time (s)')

% figure for joint angle accelerations
figure; 
subplot(3,1,1)
plot(data_time,jointData(:,3)*180/pi); ylabel('Angle Accel (deg/s^2)')
title('Joint Angle Acceleration')
legend('Joint 1','location','best')
grid on; grid minor
subplot(3,1,2)
plot(data_time,jointData(:,7)*180/pi); ylabel('Angle Accel (deg/s^2)')
legend('Joint 2','location','best')
grid on; grid minor
subplot(3,1,3)
plot(data_time,jointData(:,12)*180/pi); ylabel('Angle Accel (deg/s^2)')
legend('Joint 3','location','best')
grid on; grid minor
xlabel('Time (s)')

% figure for joint torques
figure; 
subplot(3,1,1)
plot(data_time,jointData(:,13)); ylabel('Torque Cmd (Nm)')
title('Joint Torque Commanded')
legend('Joint 1','location','best')
grid on; grid minor
subplot(3,1,2)
plot(data_time,jointData(:,14)); ylabel('Torque Cmd (Nm)')
legend('Joint 2','location','best')
grid on; grid minor
subplot(3,1,3)
plot(data_time,jointData(:,15)); ylabel('Torque Cmd (Nm)')
legend('Joint 3','location','best')
grid on; grid minor
xlabel('Time (s)')
%% Positions--- Seperate Figures for Each Axis (x, y, z)
% pos_client = out.client_cm_state.translation.position.Data;
% pos_base = out.base_state.translation.position.Data;
% pos_ee = out.ee_state.translation.position.Data;
% pos_tip= out.tip_pos.Data;
% 
% % Figure for x-positions
% figure; 
% plot(data_time,pos_client(:,1),data_time,pos_base(:,1),data_time,pos_ee(:,1),data_time,pos_tip(:,1))
% legend('Client Position x','Base Position x','EE Position x','Tip Position x','location','best')
% title('x Positions')
% xlabel('Time (s)')
% ylabel('x-Positions (m)')
% 
% % Figure for y-positions
% figure; 
% plot(data_time,pos_client(:,2),data_time,pos_base(:,2),data_time,pos_ee(:,2),data_time,pos_tip(:,2))
% legend('Client Position y','Base Position y','EE Position y','Tip Position y','location','best')
% title('y Positions')
% xlabel('Time (s)')
% ylabel('y-Positions (m)')
% 
% % Figure for z-positions
% figure; 
% plot(data_time,pos_client(:,3),data_time,pos_base(:,3),data_time,pos_ee(:,3),data_time,pos_tip(:,3))
% legend('Client Position z','Base Position z','EE Position z','Tip Position z','location','best')
% title('z Positions')
% xlabel('Time (s)')
% ylabel('z-Positions (m)')
%% Positions--- Seperate Figures for Each Object (Client, Base, EE, Tip)
% pos_client = out.client_cm_state.translation.position.Data;
pos_base = out.base_state.translation.position.Data;
pos_ee = out.ee_state.translation.position.Data;
ori_ee = out.ee_state.rotation.euler.Data;
pos_eecmd = squeeze(out.eeCmd_RelWorld.Position.Data);
ori_eecmd = squeeze(out.eeCmd_RelWorld.Euler.Data);
% pos_tip= out.tip_states.Data(:,1:3);

% figure for client positions
% figure;
% subplot(3,1,1)
% plot(data_time,pos_client(:,1)); ylabel('x-Position (m)')
% title('Client Positions')
% legend('Client Position x','location','best')
% grid on; grid minor
% subplot(3,1,2)
% plot(data_time,pos_client(:,2)); ylabel('y-Position (m)')
% legend('Client Position y','location','best')
% grid on; grid minor
% subplot(3,1,3)
% plot(data_time,pos_client(:,3)); ylabel('z-Position (m)')
% legend('Client Position z','location','best')
% grid on; grid minor
% xlabel('Time (s)')


% figure for base positions
figure;
subplot(3,1,1)
plot(data_time,pos_base(:,1)); ylabel('x-Position (m)')
title('Base Positions')
legend('Base Position x','location','best')
grid on; grid minor
subplot(3,1,2)
plot(data_time,pos_base(:,2)); ylabel('y-Position (m)')
legend('Base Position y','location','best')
grid on; grid minor
subplot(3,1,3)
plot(data_time,pos_base(:,3)); ylabel('z-Position (m)')
legend('Base Position z','location','best')
grid on; grid minor
xlabel('Time (s)')

% figure for ee positions
figure; 
subplot(3,1,1); hold all;
plot(data_time,pos_ee(:,1)); plot(data_time,pos_eecmd(1,:)'); ylabel('x-Position (m)')
title('EE Positions')
legend('EE Position x','location','best')
grid on; grid minor
subplot(3,1,2); hold all;
plot(data_time,pos_ee(:,2)); plot(data_time,pos_eecmd(2,:)'); ylabel('y-Position (m)')
legend('EE Position y','location','best')
grid on; grid minor
subplot(3,1,3); hold all;
plot(data_time,pos_ee(:,3)); plot(data_time,pos_eecmd(3,:)'); ylabel('z-Position (m)')
legend('EE Position z','location','best')
grid on; grid minor
xlabel('Time (s)')

% figure for ee orientation
figure;
subplot(3,1,1); hold all;
plot(data_time,ori_ee(:,1)*rtd); plot(data_time,ori_eecmd(1,:)'*rtd); ylabel('x-Orientation (deg)')
title('EE Orientation')
legend('EE Orientation x','location','best')
grid on; grid minor
subplot(3,1,2); hold all;
plot(data_time,ori_ee(:,2)*rtd); plot(data_time,ori_eecmd(2,:)'*rtd); ylabel('y-Orientation (deg)')
legend('EE Orientation y','location','best')
grid on; grid minor
subplot(3,1,3); hold all;
plot(data_time,ori_ee(:,3)*rtd); plot(data_time,ori_eecmd(3,:)'*rtd); ylabel('z-Orientation (deg)')
legend('EE Orientation z','location','best')
grid on; grid minor
xlabel('Time (s)')

% figure for tip positions
% figure;
% subplot(3,1,1)
% plot(data_time,pos_tip(:,1)); ylabel('x-Position (m)')
% title('Tip Positions')
% legend('Tip Position x','location','best')
% grid on; grid minor
% subplot(3,1,2)
% plot(data_time,pos_tip(:,2)); ylabel('y-Position (m)')
% legend('Tip Position y','location','best')
% grid on; grid minor
% subplot(3,1,3)
% plot(data_time,pos_tip(:,3)); ylabel('z-Position (m)')
% legend('Tip Position z','location','best')
% grid on; grid minor
% xlabel('Time (s)')


% figure for Planar (x,y) tip trajectory
% figure;
% plot(pos_tip(:,1),pos_tip(:,2))
% title('Tip Trajectory')
% xlabel('x-Position (m)')
% ylabel('y-Position (m)')
%% Positions--- Everything on One (NOT RECOMMENDED)
% pos_client = out.client_cm_state.translation.position;
% pos_base = out.base_state.translation.position;
% pos_ee = out.ee_state.translation.position;
% figure;
% plot(pos_client)
% hold on
% plot(pos_base)
% hold on
% plot(pos_ee)
% legend('Client Position x','Client Position y', 'Client Position z','Base Position x','Base Position y', 'Base Position z','EE Position x','EE Position y', 'EE Position z','location','best')
% title('Positions')
% hold off
%% Velocities--- Seperate Figures for Each Axis (x, y, z)
% vel_client = out.client_cm_state.translation.velocity.Data;
% vel_base = out.base_state.translation.velocity.Data;
% vel_ee = out.ee_state.translation.velocity.Data;
% 
% % Figure for x-velocities
% figure; 
% plot(data_time,vel_client(:,1),data_time,vel_base(:,1),data_time,vel_ee(:,1))
% legend('Client Velocity x','Base Velocity x','EE Velocity x','location','best')
% title('x Velocities')
% xlabel('Time (s)')
% ylabel('x-Velocities (m/s)')
% 
% % Figure for y-positions
% figure; 
% plot(data_time,vel_client(:,2),data_time,vel_base(:,2),data_time,vel_ee(:,2))
% legend('Client Velocity y','Base Velocity y','EE Velocity y','location','best')
% title('y Velocities')
% xlabel('Time (s)')
% ylabel('y-Velocities (m/s)')
% 
% % Figure for z-positions
% figure; 
% plot(data_time,vel_client(:,3),data_time,vel_base(:,3),data_time,vel_ee(:,3))
% legend('Client Velocity z','Base Velocity z','EE Velocity z','location','best')
% title('z Velocities')
% xlabel('Time (s)')
% ylabel('z-Velocities (m/s)')
%% Velocities--- Seperate Figures for Each Object (Client, Base, EE)
% vel_client = out.client_cm_state.translation.velocity.Data;
vel_base = out.base_state.translation.velocity.Data;
vel_ee = out.ee_state.translation.velocity.Data;
% vel_tip = out.tip_states.Data(:,4:6);

% figure for client velocities
% figure;
% subplot(3,1,1)
% plot(data_time,vel_client(:,1)); ylabel('Velocity (m/s)')
% title('Client Velocities')
% legend('Client Velocity x', 'location','best')
% grid on; grid minor
% subplot(3,1,2)
% plot(data_time,vel_client(:,2)); ylabel('Velocity (m/s)')
% legend('Client Velocity y', 'location','best')
% grid on; grid minor
% subplot(3,1,3)
% plot(data_time,vel_client(:,3)); ylabel('Velocity (m/s)')
% legend('Client Velocity z', 'location','best')
% grid on; grid minor
% xlabel('Time (s)')

% figure for base velocities
figure;
subplot(3,1,1)
plot(data_time,vel_base(:,1)); ylabel('Velocity (m/s)')
title('Base Velocities')
legend('Base Velocity x', 'location','best')
grid on; grid minor
subplot(3,1,2)
plot(data_time,vel_base(:,2)); ylabel('Velocity (m/s)')
legend('Base Velocity y', 'location','best')
grid on; grid minor
subplot(3,1,3)
plot(data_time,vel_base(:,3)); ylabel('Velocity (m/s)')
legend('Base Velocity z', 'location','best')
grid on; grid minor
xlabel('Time (s)')

% figure for ee velocities
figure;
subplot(3,1,1)
plot(data_time,vel_ee(:,1)); ylabel('Velocity (m/s)')
title('EE Velocities')
legend('EE Velocity x', 'location','best')
grid on; grid minor
subplot(3,1,2)
plot(data_time,vel_ee(:,2)); ylabel('Velocity (m/s)')
legend('EE Velocity y', 'location','best')
grid on; grid minor
subplot(3,1,3)
plot(data_time,vel_ee(:,3)); ylabel('Velocity (m/s)')
legend('EE Velocity z', 'location','best')
grid on; grid minor
xlabel('Time (s)')

%figure for tip velocities
% figure;
% subplot(3,1,1)
% plot(data_time,vel_tip(:,1)); ylabel('Velocity (m/s)')
% title('Tip Velocities')
% legend('Tip Velocity x', 'location','best')
% grid on; grid minor
% subplot(3,1,2)
% plot(data_time,vel_tip(:,2)); ylabel('Velocity (m/s)')
% legend('Tip Velocity y', 'location','best')
% grid on; grid minor
% subplot(3,1,3)
% plot(data_time,vel_tip(:,3)); ylabel('Velocity (m/s)')
% legend('Tip Velocity z', 'location','best')
% grid on; grid minor
% xlabel('Time (s)')
%% Velocities--- Everything on One (NOT RECOMMENDED)
% vel_client = out.client_cm_state.translation.velocity;
% vel_base = out.base_state.translation.velocity;
% vel_ee = out.ee_state.translation.velocity;
% figure;
% plot(vel_client)
% hold on
% plot(vel_base)
% hold on
% plot(vel_ee)
% legend('Client Velocity x','Client Velocity y', 'Client Velocity z','Base Velocity x','Base Velocity y', 'Base Velocity z','EE Velocity x','EE Velocity y', 'EE Velocity z','location','best')
% title('Velocities')
% hold off
%% Plot Force on Rod
% F_rod = out.rod_force_torque.Data;
% 
% % Figure for all forces 
% figure;
% subplot(3,1,1)
% plot(data_time,F_rod(:,1)); ylabel('Force (N)')
% title('Rod Forces')
% legend('Rod Force x','location','best')
% grid on; grid minor
% subplot(3,1,2)
% plot(data_time,F_rod(:,2)); ylabel('Force (N)')
% legend('Rod Force y','location','best')
% grid on; grid minor
% subplot(3,1,3)
% plot(data_time,F_rod(:,3)); ylabel('Force (N)')
% legend('Rod Force z','location','best')
% grid on; grid minor
% xlabel('Time (s)')
%% Plot Client Rotation
% client_rot = out.client_cm_state.rotation.euler.Data*(180/pi);
% figure;
% subplot(3,1,1)
% plot(data_time,client_rot(:,1)); ylabel('Angle (deg)')
% title('Client Euler Angles')
% legend('Euler x','location','best')
% grid on; grid minor
% subplot(3,1,2)
% plot(data_time,client_rot(:,2)); ylabel('Angle (deg)')
% legend('Euler y','location','best')
% grid on; grid minor
% subplot(3,1,3)
% plot(data_time,client_rot(:,3)); ylabel('Angle (deg)')
% legend('Euler z','location','best')
% grid on; grid minor
% xlabel('Time (s)')
%% Distance Between Tip and Client
% pos_client = out.client_cm_state.translation.position.Data;
% %ypos_client_edge = pos_client(:,2) -  
% pos_tip = out.tip_pos.Data;
% ydis_tip_client = pos_client(:,2) - pos_tip(:,2);
% figure;
% plot(data_time,ydis_tip_client); 
% title('Distance Between Tip and Client Edge')
% xlabel('Time (s)')
% ylabel('Distance (m)')