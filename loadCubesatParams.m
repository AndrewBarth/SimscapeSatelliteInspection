dtr = pi/180;


% Earth constants
Earth.radius = 6378*1000; % meters
Earth.mu = 398600*1000^3; % m^3/s^2

% Set orbit parameters
orbit.altitude = 500*1000; % kilometers
orbit.mean_motion = sqrt(Earth.mu/(Earth.radius+orbit.altitude)^3); % seconds^(-1)
orbit.period = 2*pi/orbit.mean_motion; % seconds


%% Define Cubesat initial conditions
nsat=4;

% Define task orbit for 1st Cubesat
b = 2.5;
y0 = -2*b;
inc = 45*dtr;
% Initialize at chief
% [rinteci, vinteci] = hill2eci(client.IC_Position, client.IC_Velocity, [0  -100 0], [0  0 0]);
% initialize in PRO
% [rinteci, vinteci] = hill2eci(client.IC_Position, client.IC_Velocity, [0  y0 0], [0.5*y0*orbit.mean_motion 0 tan(inc)*0.5*y0*orbit.mean_motion]);
% initial_state = [rinteci; vinteci]';

initial_state = [0  y0 0  0.5*y0*orbit.mean_motion 0 tan(inc)*0.5*y0*orbit.mean_motion];

cubesat(1).refRadius = 10;  % meters
cubesat(1).refPeriod = 6*60; % seconds

cubesat(1).mass = 3; %kg
cubesat(1).dim = [0.1 0.1 0.3];
cubesat(1).IC.rel_position = [initial_state(1:3)]; % Units?
cubesat(1).IC.rel_velocity = [initial_state(4:6)]; % Units?
cubesat(1).IC.rel_orientation = [0 0 0]*dtr;

% Define orbit for 2nd Cubesat
b = 5;
y0 = -2*b;
inc = 0*dtr;
% Initialize at chief
% [rinteci, vinteci] = hill2eci(client.IC_Position, client.IC_Velocity, [0  -100 0], [0  0 0]);
% initialize in PRO
% [rinteci, vinteci] = hill2eci(client.IC_Position, client.IC_Velocity, [0  y0 0], [0.5*y0*orbit.mean_motion 0 tan(inc)*0.5*y0*orbit.mean_motion]);
initial_state = [0  y0 0  0.5*y0*orbit.mean_motion 0 tan(inc)*0.5*y0*orbit.mean_motion];
cubesat(2).refRadius = 15; % meters
cubesat(2).refPeriod = 6*60; % seconds

cubesat(2).mass = 3; %kg
cubesat(2).dim = [0.1 0.1 0.3];
cubesat(2).IC.rel_position = [initial_state(1:3)]; % Units?
cubesat(2).IC.rel_velocity = [initial_state(4:6)]; % Units?
cubesat(2).IC.rel_orientation = [0 0 0]*dtr;

% Define orbit for 3rd Cubesat
b = 10;
y0 = -2*b;
inc = 75*dtr;
% Initialize at chief
% [rinteci, vinteci] = hill2eci(client.IC_Position, client.IC_Velocity, [0  -100 0], [0  0 0]);
% initialize in PRO
% [rinteci, vinteci] = hill2eci(client.IC_Position, client.IC_Velocity, [0  y0 0], [0.5*y0*orbit.mean_motion 0 tan(inc)*0.5*y0*orbit.mean_motion]);
initial_state = [0  y0 0 0.5*y0*orbit.mean_motion 0 tan(inc)*0.5*y0*orbit.mean_motion];
cubesat(3).refRadius = 20; % meters
cubesat(3).refPeriod = 6*60; % seconds

cubesat(3).mass = 3; % kg
cubesat(3).dim = [0.1 0.1 0.3];
cubesat(3).IC.rel_position = [initial_state(1:3)]; % Units?
cubesat(3).IC.rel_velocity = [initial_state(4:6)]; % Units?
cubesat(3).IC.rel_orientation = [0 0 0]*dtr;

% Define orbit for 4th Cubesat
b = 20;
y0 = -2*b;
inc = 70*dtr;
% Initialize at chief
% [rinteci, vinteci] = hill2eci(client.IC_Position, client.IC_Velocity, [0  -100 0], [0  0 0]);
% initialize in PRO
% [rinteci, vinteci] = hill2eci(client.IC_Position, client.IC_Velocity, [0  y0 0], [0.5*y0*orbit.mean_motion 0 tan(inc)*0.5*y0*orbit.mean_motion]);
initial_state = [0  y0 0 0.5*y0*orbit.mean_motion 0 tan(inc)*0.5*y0*orbit.mean_motion];
cubesat(4).refRadius = 30; % meters
cubesat(4).refPeriod = 6*60; % seconds

cubesat(4).mass = 3; % kg
cubesat(4).dim = [0.1 0.1 0.3];
cubesat(4).IC.rel_position = [initial_state(1:3)]; % Units?
cubesat(4).IC.rel_velocity = [initial_state(4:6)]; % Units?
cubesat(4).IC.rel_orientation = [0 0 0]*dtr;