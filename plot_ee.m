

figure; 
subplot(3,1,1); hold all;
plot(out.eeCmd.Time,squeeze(out.eeCmd.Data(1,1,:)))
plot(out.ee_state.translation.position.Time,out.ee_state.translation.position.Data(:,1))
xlabel('Time (s)'),ylabel('Position (m)')
title('X Axis End Effector Position')
legend('Cmd','Actual')

subplot(3,1,2); hold all;
plot(out.eeCmd.Time,squeeze(out.eeCmd.Data(1,2,:)))
plot(out.ee_state.translation.position.Time,out.ee_state.translation.position.Data(:,2))
xlabel('Time (s)'),ylabel('Position (m)')
title('Y Axis End Effector Position')
legend('Cmd','Actual')

subplot(3,1,3); hold all;
plot(out.eeCmd.Time,squeeze(out.eeCmd.Data(1,3,:)))
plot(out.ee_state.translation.position.Time,out.ee_state.translation.position.Data(:,3))
xlabel('Time (s)'),ylabel('Position (m)')
title('Z Axis End Effector Position')
legend('Cmd','Actual')

% figure; 
% subplot(3,1,1); hold all;
% plot(out.eeCmd.Time,squeeze(out.eeCmd.Data(1,4,:))*180/pi)
% plot(out.ee_state.rotation.euler.Time,out.ee_state.rotation.euler.Data(:,1)*180/pi)
% xlabel('Time (s)'),ylabel('Angle (deg)')
% title('End Effector Roll Angle')
% legend('Cmd','Actual')
% 
% subplot(3,1,2); hold all;
% plot(out.eeCmd.Time,squeeze(out.eeCmd.Data(1,5,:))*180/pi)
% plot(out.ee_state.rotation.euler.Time,out.ee_state.rotation.euler.Data(:,2)*180/pi)
% xlabel('Time (s)'),ylabel('Angle (deg)')
% title('End Effector Pitch Angle')
% legend('Cmd','Actual')
% 
% subplot(3,1,3); hold all;
% plot(out.eeCmd.Time,squeeze(out.eeCmd.Data(1,6,:))*180/pi)
% plot(out.ee_state.rotation.euler.Time,out.ee_state.translation.position.Data(:,3)*180/pi)
% xlabel('Time (s)'),ylabel('Angle (deg)')
% title('End Effector Yaw Angle')
% legend('Cmd','Actual')