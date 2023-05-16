
rod_base.rotation = [ 0 0 90]*pi/180;

jointControlData.Kp = [.01 .01 .01 .001 .001 .001]*0.7;
jointControlData.Kd = [.01 .01 .01 .001 .001 .001]*4;
jointControlData.Ki = [.01 .01 .01 .001 .001 .001]*0.;

jointControlData.refTime = [0 5 30 50 70];
jointControlData.jointControlModeVec = [1 2 2 2 2];

jointControlData.eeCmd = zeros(1,12);

jointControlData.eeRefTraj(1,:) = [-0.7050   -0.0625    0.4410  180.0*dtr 0.0*dtr 180.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];  % Joint 1 90, Joint 7 -90 deg
jointControlData.eeRefTraj(2,:) = [-0.9750    0.2525    0.4410  180.0*dtr 0.0*dtr  90.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];  % Joint 1 90 deg
jointControlData.eeRefTraj(3,:) = [-0.0025   -0.7250    0.4410  180.0*dtr 0.0*dtr 180.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(4,:) = [-0.0025   -0.7250    0.4410  180.0*dtr 0.0*dtr 180.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(5,:) = [-0.0025   -0.7250    0.4410  180.0*dtr 0.0*dtr 180.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];



