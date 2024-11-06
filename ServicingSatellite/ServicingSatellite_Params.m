% Define default parameters for the servicing satellite
dtr = pi/180;

% Mass Properties of servicing satellite
% sat.service.mass = 150;
sat.service.mass = 20;
sat.service.radius = 0.25;
sat.service.length = 0.75;
% The following mass properties are derived from simscape
sat.service.Com = [0 0 0];
sat.service.MoI = [5.23993, 5.23993, 4.22985];
sat.service.PoI = [0 0 0];

% Solar panel masses are ignored by controller
sat.service.panel.mass = 0.25;
sat.service.panel.dim = [0.5 0.005 0.3];
sat.service.panel_mount.mass = 0.25;
sat.service.panel_mount.dim = [0.05 0.01 0.01];

% Initial state of servicing satellite
% Position in m relative to world frame (which is fixed in the client)
sat.service.IC.pose.position.x = 0.0;
sat.service.IC.pose.position.y = 0.0;
sat.service.IC.pose.position.z = 0.0;
% sat.service.IC.pose.position.x = 0.05;
sat.service.IC.pose.position.y = -1.5;
% sat.service.IC.pose.position.z = -0.25;
% Velocity in m/s
sat.service.IC.twist.linear.x = 0.0;
sat.service.IC.twist.linear.y = 0.0;
sat.service.IC.twist.linear.z = 0.0;
% Attitude in rad Z-Y-X order and sequence
sat.service.IC.pose.orientation = [20.0 0.0 0.0]*dtr;
sat.service.IC.pose.orientation = [0.0 0.0 0.0]*dtr;
% Angular velocity in rad/s
sat.service.IC.twist.angular = [0.0 0.0 0.0]*dtr;

% Rotation from satellite body to camera attach point
% Angles in rad Z-Y-X order and sequence
sat.service.camera.attachOrientation = [-90 0 22.5]*dtr;

% Rotation from camera attach point to camera body frame
% Angles in rad Z-Y-X order and sequence
sat.service.camera.bodyOrientation = [45 0 90]*dtr;