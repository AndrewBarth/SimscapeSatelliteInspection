% Define servicing satellite controller data

dtr = pi/180;

% Translational commands and gains
% This is a relative position and velocity to the client
satControlData.Trans.cmdPos = IC.rel_position - [-0.2 0.5 -0.25];
satControlData.Trans.cmdVel = [0 0 0];

satControlData.Trans.Kp = [15 15 15];
satControlData.Trans.Kd = [120 120 120];
satControlData.Trans.Ki = [0.05 0.05 0.05];

satControlData.Trans.forceLimit = 20;

% Rotational commands and gains
% This is a relative angle and rate to the client
% If the client is rotating it will match the rate
satControlData.Rot.cmdAngle = [0 0 0]*dtr;
satControlData.Rot.cmdRate = [0 0 0]*dtr;

% satControlData.Rot.Kp = [50 50 50];
% satControlData.Rot.Kd = [200 200 200];
% satControlData.Rot.Ki = [0.05 0.05 0.05];
% Disable rotational control 
satControlData.Rot.Kp = [0 0 0];
satControlData.Rot.Kd = [0 0 0];
satControlData.Rot.Ki = [0 0 0];

satControlData.Rot.torqueLimit = 10;

% Create Simulink Bus
busInfo = Simulink.Bus.createObject(satControlData);
satControlDataBus = evalin('base',busInfo.busName);