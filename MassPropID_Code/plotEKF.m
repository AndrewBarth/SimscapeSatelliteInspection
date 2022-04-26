
rtd = 180/pi;

actualRate = client_cm.rotation.angular_rate.Data;

figure;
subplot(4,1,1);plot(timeVec,rotState(1:end-1,4),timeVec,observedQuat(:,1))
legend('Estimated','Observed')
xlabel('Time (sec)');ylabel('Quaternion Element')
title('Target Attitude Quaternion Scalar')

subplot(4,1,2);plot(timeVec,rotState(1:end-1,5),timeVec,observedQuat(:,2))
legend('Estimated','Observed')
xlabel('Time (sec)');ylabel('Quaternion Element')
title('Target Attitude Quaternion Vector (1)')

subplot(4,1,3);plot(timeVec,rotState(1:end-1,6),timeVec,observedQuat(:,3))
legend('Estimated','Observed')
xlabel('Time (sec)');ylabel('Quaternion Element')
title('Target Attitude Quaternion Vector (2)')

subplot(4,1,4);plot(timeVec,rotState(1:end-1,7),timeVec,observedQuat(:,4))
legend('Estimated','Observed')
xlabel('Time (sec)');ylabel('Quaternion Element')
title('Target Attitude Quaternion Vector (3)')

figure;
subplot(3,1,1);plot(timeVec,rotState(1:end-1,1)*rtd,timeVec,actualRate(:,1)*rtd)
legend('Estimated','Observed')
xlabel('Time (sec)');ylabel('Angular Rate (deg/s)')
title('Target Angular Rate X')

subplot(3,1,2);plot(timeVec,rotState(1:end-1,2)*rtd,timeVec,actualRate(:,2)*rtd)
legend('Estimated','Observed')
xlabel('Time (sec)');ylabel('Angular Rate (deg/s)')
title('Target Angular Rate Y')

subplot(3,1,3);plot(timeVec,rotState(1:end-1,3)*rtd,timeVec,actualRate(:,3)*rtd)
legend('Estimated','Observed')
xlabel('Time (sec)');ylabel('Angular Rate (deg/s)')
title('Target Angular Rate Z')