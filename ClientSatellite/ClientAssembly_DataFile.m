% Simscape(TM) Multibody(TM) version: 7.3

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
client.smiData.RigidTransform(1).translation = [0.0 0.0 0.0];
client.smiData.RigidTransform(1).angle = 0.0;
client.smiData.RigidTransform(1).axis = [0.0 0.0 0.0];
client.smiData.RigidTransform(1).ID = '';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
%client.smiData.RigidTransform(1).translation = [-29.387985525019083 0.3087255108417723 0.75535809323684777];  % in
client.smiData.RigidTransform(1).translation = [0 0 0];  % in
client.smiData.RigidTransform(1).angle = 0;  % rad
client.smiData.RigidTransform(1).axis = [0 0 0];
client.smiData.RigidTransform(1).ID = 'RootGround[ClientBase-1]';


%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
client.smiData.Solid(1).mass = 0.0;
client.smiData.Solid(1).CoM = [0.0 0.0 0.0];
client.smiData.Solid(1).MoI = [0.0 0.0 0.0];
client.smiData.Solid(1).PoI = [0.0 0.0 0.0];
client.smiData.Solid(1).color = [0.0 0.0 0.0];
client.smiData.Solid(1).opacity = 0.0;
client.smiData.Solid(1).ID = '';

%Inertia Type - Custom
%Visual Properties - Simple
client.smiData.Solid(1).mass = 2029.7277138210486;  % kg
client.smiData.Solid(1).CoM = [537.02790658997583 0 0];  % mm
client.smiData.Solid(1).MoI = [82209575.442515537 254114687.9854086 254114687.9854086];  % kg*mm^2
client.smiData.Solid(1).PoI = [3.1072583742131062e-09 1.0884393380146985e-09 5.6498381852836825e-09];  % kg*mm^2
client.smiData.Solid(1).color = [0.77647058823529413 0.75686274509803919 0.73725490196078436];
client.smiData.Solid(1).opacity = 1;
client.smiData.Solid(1).ID = 'ClientBase*:*Default';

