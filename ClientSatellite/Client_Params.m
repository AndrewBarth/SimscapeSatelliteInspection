% Define default parameters for the client
dtr = pi/180;

% Relative position to the world frame
% client.IC.rel_position = [-0.25 2 0.0] - [-0.2 0.5 -0.25];
client.IC.rel_position = [0 0 0];

% Attitude in rad Z-Y-X order and sequence
client.IC.rel_orientation = [0 0 0]*dtr;

% Angular velocity in rad/s
client.IC.twist.angular = [0.0 0.0 0.0]*dtr;