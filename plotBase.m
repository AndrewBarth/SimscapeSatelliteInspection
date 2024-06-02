
pos_base = out.base_state.translation.position.Data;
ori_base = out.base_state.rotation.euler.Data;
angv_base = out.base_state.rotation.angular_rate.Data;
data_time = out.base_state.translation.position.Time;
rtd = 180/pi;

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

% figure for base orientation
figure;
subplot(3,1,1); hold all;
plot(data_time,ori_base(:,1)*rtd);  ylabel('x-Orientation (deg)')
title('Base Orientation')
legend('Base Orientation x','location','best')
grid on; grid minor
subplot(3,1,2); hold all;
plot(data_time,ori_base(:,2)*rtd);  ylabel('y-Orientation (deg)')
legend('Base Orientation y','location','best')
grid on; grid minor
subplot(3,1,3); hold all;
plot(data_time,ori_base(:,3)*rtd);  ylabel('z-Orientation (deg)')
legend('Base Orientation z','location','best')
grid on; grid minor
xlabel('Time (s)')

% figure for base angular velocity
figure;
subplot(3,1,1); hold all;
plot(data_time,angv_base(:,1)*rtd);  ylabel('x-Angular Velocity (deg/s)')
title('Base Angular Velocity')
legend('Base Angular Velocity x','location','best')
grid on; grid minor
subplot(3,1,2); hold all;
plot(data_time,angv_base(:,2)*rtd);  ylabel('y-Angular Velocity (deg/s)')
legend('Base Angular Velocity y','location','best')
grid on; grid minor
subplot(3,1,3); hold all;
plot(data_time,angv_base(:,3)*rtd);  ylabel('z-Angular Velocity (deg/s)')
legend('Base Angular Velocity z','location','best')
grid on; grid minor
xlabel('Time (s)')