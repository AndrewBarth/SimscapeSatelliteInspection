


joint_cmd   = out.desiredThetadot.Data;
joint_state = out.joint_state6.Data;
data_time = out.desiredThetadot.Time;

figure;plot(data_time,joint_cmd(:,1),data_time,joint_state(:,2));title('Arm 2 Joint 1 Rate')
legend('Cmd','Actual')

figure;plot(data_time,joint_cmd(:,2),data_time,joint_state(:,6));title('Arm 2 Joint 2 Rate')
legend('Cmd','Actual')

figure;plot(data_time,joint_cmd(:,3),data_time,joint_state(:,10));title('Arm 2 Joint 3 Rate')
legend('Cmd','Actual')

figure;plot(data_time,joint_cmd(:,4),data_time,joint_state(:,14));title('Arm 2 Joint 4 Rate')
legend('Cmd','Actual')