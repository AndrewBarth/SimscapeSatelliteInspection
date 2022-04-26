

figure; 
plot(out.joint_state.Data(:,[1,4,7])*180/pi); 
legend('Joint 1','Joint 2','Joint 3')
xlabel('Time (s)');ylabel('Joint Angle (deg)')
title('Joint Angles')


figure;
plot(out.joint_state.Data(:,[2,5,8])*180/pi);
legend('Joint 1','Joint 2','Joint 3')
xlabel('Time (s)');ylabel('Joint Rate (deg/s)')
title('Joint Rates')

figure;
plot(out.joint_state.Data(:,[3,6,9])*180/pi);
legend('Joint 1','Joint 2','Joint 3')
xlabel('Time (s)');ylabel('Joint Accel (deg/s2)')
title('Joint Accelerations')

figure;
plot(out.joint_cmds.Data);
legend('Joint 1','Joint 2','Joint 3')
xlabel('Time (s)');ylabel('Joint Torque Cmd (Nm)')
title('Joint Torque Commands')