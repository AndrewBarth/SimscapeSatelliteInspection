addpath('Utilities');
addpath('Planar_3Link_Arm');
addpath('ClientSatellite');
addpath('Manipulator_Control');

dtr = pi/180;

nLink = 3;
Satellite_Params

loadBusData

endTime = 50;


sat.service.dim = [2 1 0.05];
sat.service.mass = 500;
% Initial state of servicing satellite
% Position in m
sat.service.IC.pose.position.x = 0.0;
sat.service.IC.pose.position.y = 0.0;
sat.service.IC.pose.position.z = 0.0;
% Velocity in m/s
sat.service.IC.twist.linear.x = 0.0;
sat.service.IC.twist.linear.y = 0.0;
sat.service.IC.twist.linear.z = 0.0;
% Attitude in rad Z-Y-X order and sequence
sat.service.IC.pose.orientation = [0 0.0 0]*dtr;

sat.client.mass = 1000;
sat.client.dim = [1.0 0.5 0.05];
sat.client.IC.pose.position.x = 5.0;
sat.client.IC.pose.position.y = 0.0;
sat.client.IC.pose.position.z = 0.0;

sat.client.IC.twist.linear.x = 0.02;
sat.client.IC.twist.linear.y = 0.0;
sat.client.IC.twist.linear.z = 0.0;

% Attitude in rad Z-Y-X order and sequence
sat.client.IC.pose.orientation = [0 0 0]*dtr;

Link_Length = [1.0 1.0 1.0];
%Link_Mass = [20.0 10.0 5.0];
Link_Mass = [1 1 1];

Initial_Angles = [0 45 45]*dtr;


% eeRefTraj(1,:) = [1.7071     1.7071  90.0*dtr];
% eeRefTraj(2,:) = [1.7071     1.7071  90.0*dtr];
eeRefTraj(1,:) = [0 0 0];
eeRefTraj(2,:) = [0 0 0];
eeRefTraj(3,:) = [1.7071     1.7071  90.0*dtr];
eeRefTraj(4,:) = [1.7071     1.7071  90.0*dtr];

eeRefTraj(3,:) = [2.0     -2.0  -90.0*dtr];
eeRefTraj(4,:) = [2.0     -3.0  -60.0*dtr];
eeRefTraj(5,:) = [2.0     -3.0  -60.0*dtr];

% eeRefTraj(2,:) = [0.0       0.5     0.0*dtr];
% eeRefTraj(3,:) = [0.0       0.5     0.0*dtr];
% eeRefTraj(4,:) = [0.0       0.8     0.0*dtr];
eeRefTime = [0 10 20 40 50];