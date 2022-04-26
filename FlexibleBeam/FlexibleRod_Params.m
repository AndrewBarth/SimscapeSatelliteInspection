% Properties of aluminum
alu.rho = 2700; % kg*m^3
alu.E   = 70;   % GPa
alu.G   = 26;   % GPa

% Properties of fiberglass
% https://en.wikipedia.org/wiki/List_of_materials_properties#Mechanical_properties
fibG.rho = 1.7;
fibG.E = 17.2/4;
fibG.G = 26.0/4; % not sure of this value

%material = alu;
material = fibG;

% Beam length, in m
beam.L = 1;



% Properties of the wall
% wall.dim = [1.0 0.5 1.0];
% wall.rho = alu.rho;
% wall.clr = [0.4 0.4 0.4];
% w=0;
% wall.off = -w/4; % offset

% Properties of the beam
rod.length = 1;          % Length (m)
rod.radius = 0.0025;     % Radius (m)
rod.rho = material.rho;  % Density (kg/m3)
rod.E   = material.E;    % Young's Modulous (GPa)
rod.G   = material.G;    % Shear Modulous (GPa)

rod.stiffness = 0.0001;  % Stiffness coefficient (s)
% beam.bet = 1e-4; % s
rod.N   = 2;             % Number of elements
% beam.clr = [0.8 0.8 0.8];

% % Properties of rigid tip of the beam
% t = 0.005;
% tip.t   = t/2;
% tip.rho = material.rho;
% tip.clr = [0.0 1.0 1.0];
% 
% % Properties of graphic representations
% % of cross-sectional centers (reference,
% % centroid, shear center)
% grph.dim   = [t t t/2];
% grph.c.clr = [1.0 0.0 0.0];
% grph.r.clr = [0.0 0.6 0.0];
% grph.s.clr = [0.0 0.0 1.0];
% 
% % Properties of marker for force/moment
% % application point
% mrkr.L   = t/2;
% mrkr.r   = 0.8*t/2;
% mrkr.clr = [1.0 1.0 0.0];

% Transformation from gripper attach point to the rod base
rod_base.offset = [0 0 0];
% Z - Y - X rotation sequence (angles in radians)
rod_base.rotation = [ 10 90 0]*pi/180;
rod_base.rotation = [ 0 90 0]*pi/180;