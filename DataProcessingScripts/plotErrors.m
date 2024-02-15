%% ALWAYS RUN THIS SECTION AS A FIRST STEP (YOU ONLY NEED TO DO IT ONCE)

errorData = out.jointControlError.Data;
data_time = (0:endTime/(length(errorData)-1):endTime)';
rtd = 180/pi;

poserr_ee = squeeze(out.jointControlError.Data(1,1:3,:))';
orierr_ee = squeeze(out.jointControlError.Data(1,4:6,:))';
velerr_ee = squeeze(out.jointControlError.Data(1,7:9,:))';
rateerr_ee = squeeze(out.jointControlError.Data(1,10:12,:))'*rtd;


% figure for ee position error
figure;
subplot(3,1,1)
plot(data_time,poserr_ee(:,1)); ylabel('x-Position (m)')
title('EE Position Error')
legend('EE Position Error x','location','best')
grid on; grid minor
subplot(3,1,2)
plot(data_time,poserr_ee(:,2)); ylabel('y-Position (m)')
legend('EE Position Error y','location','best')
grid on; grid minor
subplot(3,1,3)
plot(data_time,poserr_ee(:,3)); ylabel('z-Position (m)')
legend('EE Position Error z','location','best')
grid on; grid minor
xlabel('Time (s)')

% figure for ee orientation error
figure;
subplot(3,1,1)
plot(data_time,orierr_ee(:,1)); ylabel('x-Orientation (--)')
title('EE Orientation Error')
legend('EE Orientation Error x','location','best')
grid on; grid minor
subplot(3,1,2)
plot(data_time,orierr_ee(:,2)); ylabel('y-Orientation (--)')
legend('EE Orientation Error y','location','best')
grid on; grid minor
subplot(3,1,3)
plot(data_time,orierr_ee(:,3)); ylabel('z-Orientation (--)')
legend('EE Orientation Error z','location','best')
grid on; grid minor
xlabel('Time (s)')

% figure for ee velocity errors
figure;
subplot(3,1,1)
plot(data_time,velerr_ee(:,1)); ylabel('Velocity (m/s)')
title('EE Velocity Error')
legend('EE Velocity Error x', 'location','best')
grid on; grid minor
subplot(3,1,2)
plot(data_time,velerr_ee(:,2)); ylabel('Velocity (m/s)')
legend('EE Velocity Error y', 'location','best')
grid on; grid minor
subplot(3,1,3)
plot(data_time,velerr_ee(:,3)); ylabel('Velocity (m/s)')
legend('EE Velocity Error z', 'location','best')
grid on; grid minor
xlabel('Time (s)')


% figure for ee rate errors
figure;
subplot(3,1,1)
plot(data_time,rateerr_ee(:,1)); ylabel('Angular Velocity  (deg/s)')
title('EE Angular Velocity  Error')
legend('EE Angular Velocity Error x', 'location','best')
grid on; grid minor
subplot(3,1,2)
plot(data_time,rateerr_ee(:,2)); ylabel('Angular Velocity  (deg/s)')
legend('EE Angular Velocity Error y', 'location','best')
grid on; grid minor
subplot(3,1,3)
plot(data_time,rateerr_ee(:,3)); ylabel('Angular Velocity  (deg/s)')
legend('EE Angular Velocity Error z', 'location','best')
grid on; grid minor
xlabel('Time (s)')