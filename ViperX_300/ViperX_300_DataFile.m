% Simscape(TM) Multibody(TM) version: 7.3

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(9).translation = [0.0 0.0 0.0];
smiData.RigidTransform(9).angle = 0.0;
smiData.RigidTransform(9).axis = [0.0 0.0 0.0];
smiData.RigidTransform(9).ID = '';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [0 0 0];  % mm
smiData.RigidTransform(1).angle = 90*pi/180;  % rad
smiData.RigidTransform(1).axis = [ 0 0 1 ];
smiData.RigidTransform(1).ID = 'B[ArmBase-1:-:]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [0 0 0];  % mm
smiData.RigidTransform(2).angle = 0;  % rad
smiData.RigidTransform(2).axis = [0 0 0];
smiData.RigidTransform(2).ID = 'B[ArmBase-2:-:]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [0.0 0  10];  % mm
smiData.RigidTransform(3).angle = 0;  % rad
smiData.RigidTransform(3).axis = [0 0 0];
smiData.RigidTransform(3).ID = 'B[ArmBase-1:-:ArmSegment-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [-7.5 0 0];  % mm
smiData.RigidTransform(4).angle = 0.0;  % rad
smiData.RigidTransform(4).axis = [0 0 0];
smiData.RigidTransform(4).ID = 'F[ArmBase-1:-:ArmSegment-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [0 0 -10];  % mm
smiData.RigidTransform(5).angle = 0.0;  % rad
smiData.RigidTransform(5).axis = [0 0 0];
smiData.RigidTransform(5).ID = 'B[ArmSegmentAssembly-2:ArmSegment-1:-:ArmSegmentAssembly-3:ArmSegment-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [-7.5 0 0];  % mm
smiData.RigidTransform(6).angle = 0.0;  % rad
smiData.RigidTransform(6).axis = [0 0 0];
smiData.RigidTransform(6).ID = 'F[ArmSegmentAssembly-2:ArmSegment-1:-:ArmSegmentAssembly-3:ArmSegment-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [0 0 10];  % mm
smiData.RigidTransform(7).angle = 0.0;  % rad
smiData.RigidTransform(7).axis = [0 0 0];
smiData.RigidTransform(7).ID = 'B[ArmSegmentAssembly-3:ArmSegment-1:-:Gripper-2]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(8).translation = [0 0 0];  % mm
smiData.RigidTransform(8).angle = 0.0;  % rad
smiData.RigidTransform(8).axis = [0 0 0];
smiData.RigidTransform(8).ID = 'B[ArmSegmentAssembly-3:ArmSegment-1:-:Gripper-2]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(9).translation = [0 0 -30];  % mm
smiData.RigidTransform(9).angle = 0.0;  % rad
smiData.RigidTransform(9).axis = [0 0 0];
smiData.RigidTransform(9).ID = 'F[ArmSegmentAssembly-3:ArmSegment-1:-:Gripper-2]';


%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(6).mass = 0.0;
smiData.Solid(6).CoM = [0.0 0.0 0.0];
smiData.Solid(6).MoI = [0.0 0.0 0.0];
smiData.Solid(6).PoI = [0.0 0.0 0.0];
smiData.Solid(6).color = [0.0 0.0 0.0];
smiData.Solid(6).opacity = 0.0;
smiData.Solid(6).ID = '';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 0.969034;  % kg
smiData.Solid(1).CoM = [0, 0, 0];  % m
smiData.Solid(1).MoI = [0.006024, 0.0017, 0.007162];  % kg*m^2
smiData.Solid(1).PoI = [-8.415e-05, 3.851e-06, 4.713e-05];  % kg*m^2
smiData.Solid(1).color = [0 0.043137254901960784 0.59215686274509804];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = 'Base_Link';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 0.798614;  % kg
smiData.Solid(2).CoM = [0, 0, 0];  % m
smiData.Solid(2).MoI = [0.0009388000000000001, 0.001138, 0.001201];  % kg*m^2
smiData.Solid(2).PoI = [5.9568e-06, -1.91e-08, -1e-09];  % kg*m^2
smiData.Solid(2).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = 'Shoulder_Link';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 0.792592;  % kg
smiData.Solid(3).CoM = [0, 0, 0];  % m
smiData.Solid(3).MoI = [0.008925000000000001, 0.008937, 0.0009357];  % kg*m^2
smiData.Solid(3).PoI = [0.001201, 0, 0];  % kg*m^2
smiData.Solid(3).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = 'Upper_Arm_Link';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(4).mass = 0.544659;  % kg
smiData.Solid(4).CoM = [0, 0, 0];  % m
smiData.Solid(4).MoI = [0.005447, 0.0002267, 0.005574];  % kg*m^2
smiData.Solid(4).PoI = [0, 0, -1.198e-05];  % kg*m^2
smiData.Solid(4).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = 'Forearm_Link';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(5).mass = 0.115395;  % kg
smiData.Solid(5).CoM = [0, 0, 0];  % m
smiData.Solid(5).MoI = [4.631e-05, 4.514e-05, 5.27e-05];  % kg*m^2
smiData.Solid(5).PoI = [4.2002e-06, 2.3e-09, 1.95e-08];  % kg*m^2
smiData.Solid(5).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(5).opacity = 1;
smiData.Solid(5).ID = 'Wrist_Link';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(6).mass = 0.097666;  % kg
smiData.Solid(6).CoM = [0, 0, 0];  % m
smiData.Solid(6).MoI = [3.268e-05, 2.436e-05, 2.119e-05];  % kg*m^2
smiData.Solid(6).PoI = [2.785e-07, 0, 0];  % kg*m^2
smiData.Solid(6).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(6).opacity = 1;
smiData.Solid(6).ID = 'Gripper_Link';

%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(5).Rz.Pos = 0.0;
smiData.RevoluteJoint(5).ID = '';

smiData.RevoluteJoint(1).Rz.Pos = 180.0;  % deg Bounds: -180, +180 
smiData.RevoluteJoint(1).ID = '[waist]';

smiData.RevoluteJoint(2).Rz.Pos = 70.0;  % deg  Bounds: -106, +72
smiData.RevoluteJoint(2).ID = '[shoulder]';

smiData.RevoluteJoint(3).Rz.Pos = -90.0;  % deg Bounds: -101, +92
smiData.RevoluteJoint(3).ID = '[elbow]';

smiData.RevoluteJoint(4).Rz.Pos = 90.0;  % deg Bounds: -107, +92
smiData.RevoluteJoint(4).ID = '[wrist1]';

smiData.RevoluteJoint(5).Rz.Pos = 0.0;  % deg Bounds: -180, +180
smiData.RevoluteJoint(5).ID = '[wrist2]';

smiData.RevoluteJoint(1).Rz.Pos = 0.0;  % deg Bounds: -180, +180 
smiData.RevoluteJoint(2).Rz.Pos = 0.0;  % deg  Bounds: -106, +72
smiData.RevoluteJoint(3).Rz.Pos = 0.0;  % deg Bounds: -101, +92
smiData.RevoluteJoint(4).Rz.Pos = 0.0;  % deg Bounds: -107, +92
smiData.RevoluteJoint(5).Rz.Pos = 0.0;  % deg Bounds: -180, +180

% Zero angles for joints results in straight-arm configuration
% smiData.RevoluteJoint(1).Rz.Pos = 0.0;
% smiData.RevoluteJoint(2).Rz.Pos = 0.0;
% smiData.RevoluteJoint(3).Rz.Pos = 0.0;