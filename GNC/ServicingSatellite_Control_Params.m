% Set default parameters for the control of the servicing satellite

% Translational commands and gains
satControlData_Trans.cmdVel = [0 0 0];

satControlData_Trans.Kp = [15 15 15];
satControlData_Trans.Kd = [120 120 120];
satControlData_Trans.Ki = [0.05 0.05 0.05];

satControlData_Trans.forceLimit = 20;

% Rotational commands and gains
% This is a relative angle and rate to the client
% If the client is rotating it will match the rate
satControlData_Rot.cmdAngle = [0 0 0]*dtr;
satControlData_Rot.cmdRate = [0 0 0]*dtr;

% satControlData_Rot.Kp = [50 50 50];
% satControlData_Rot.Kd = [200 200 200];
% satControlData_Rot.Ki = [0.05 0.05 0.05];
% Disable rotational control 
satControlData_Rot.Kp = [0 0 0];
satControlData_Rot.Kd = [0 0 0];
satControlData_Rot.Ki = [0 0 0];

satControlData_Rot.torqueLimit = 10;