
rtd = 180/pi;
joint_cmd   = out.desiredThetadot.Data;
joint_state1 = out.joint_state7.Data;
joint_state2 = out.joint_state8.Data;
data_time = out.desiredThetadot.Time;

figure;plot(data_time,joint_cmd(:,1),data_time,joint_state2(:,2));title('Arm 2 Joint 1 Rate')
legend('Cmd','Actual')

figure;plot(data_time,joint_cmd(:,2),data_time,joint_state2(:,6));title('Arm 2 Joint 2 Rate')
legend('Cmd','Actual')

figure;plot(data_time,joint_cmd(:,3),data_time,joint_state2(:,10));title('Arm 2 Joint 3 Rate')
legend('Cmd','Actual')

figure;subplot(3,1,1);
plot(data_time,joint_state1(:,1)*rtd,data_time,joint_state2(:,1)*rtd);title('Joint 1 Angle');xlabel('Time (s)');ylabel('Angle (deg)')
legend('Arm 1','Arm 2')
subplot(3,1,2);
plot(data_time,joint_state1(:,5)*rtd,data_time,joint_state2(:,5)*rtd);title('Joint 2 Angle');xlabel('Time (s)');ylabel('Angle (deg)')
subplot(3,1,3);
plot(data_time,joint_state1(:,9)*rtd,data_time,joint_state2(:,9)*rtd);title('Joint 3 Angle');xlabel('Time (s)');ylabel('Angle (deg)')

figure;subplot(3,1,1);
plot(data_time,joint_state1(:,2)*rtd,data_time,joint_state2(:,2)*rtd);title('Joint 1 Rate');xlabel('Time (s)');ylabel('Angle (deg/s)')
legend('Arm 1','Arm 2')
subplot(3,1,2);
plot(data_time,joint_state1(:,6)*rtd,data_time,joint_state2(:,6)*rtd);title('Joint 2 Rate');xlabel('Time (s)');ylabel('Angle (deg/s)')
subplot(3,1,3);
plot(data_time,joint_state1(:,10)*rtd,data_time,joint_state2(:,10)*rtd);title('Joint 3 Rate');xlabel('Time (s)');ylabel('Angle (deg/s)')
