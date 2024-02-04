% Simscape(TM) Multibody(TM) version: 7.3

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData
ArmBase_radius = 0.125/2;
ArmBase_height = 0.1;

ArmLink1_width = 0.04;
ArmLink1_depth = 0.05;
ArmLink1_height = 0.1;

%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(15).translation = [0.0 0.0 0.0];
smiData.RigidTransform(15).angle = 0.0;
smiData.RigidTransform(15).axis = [0.0 0.0 0.0];
smiData.RigidTransform(15).ID = '';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [0 0 ArmBase_height/2];  % m
smiData.RigidTransform(1).angle = 0;  % rad
smiData.RigidTransform(1).axis = [ 0 0 0 ];
smiData.RigidTransform(1).ID = 'ArmAttach-ArmBase1';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [0 0 0];  % m
smiData.RigidTransform(2).angle = 90*pi/180;  % rad
smiData.RigidTransform(2).axis = [0 0 1];
smiData.RigidTransform(2).ID = 'ArmBase-1-ArmBase-2]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [0.0 0 ArmBase_height/2];  % m
smiData.RigidTransform(3).angle = 0;  % rad
smiData.RigidTransform(3).axis = [0 0 0];
smiData.RigidTransform(3).ID = 'ArmBase-2:-:Joint-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [0 0 ArmLink1_height/2];  % m
smiData.RigidTransform(4).angle = 0.0;  % rad
smiData.RigidTransform(4).axis = [0 0 0];
smiData.RigidTransform(4).ID = 'F[Joint-1:-:ArmLink-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [0 0 ArmLink1_height/2];  % m
smiData.RigidTransform(5).angle = 90.0*pi/180;  % rad
smiData.RigidTransform(5).axis = [1 0 0];
smiData.RigidTransform(5).ID = 'B[ArmLink1:Joint-2]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [0 0 0];  % mm
smiData.RigidTransform(6).angle = 0.0;  % rad
smiData.RigidTransform(6).axis = [0 0 0];
smiData.RigidTransform(6).ID = 'B[Joint-2:ArmSegmentAssembly-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [0 0 10];  % mm
smiData.RigidTransform(7).angle = 0.0;  % rad
smiData.RigidTransform(7).axis = [0 0 0];
smiData.RigidTransform(7).ID = '[ArmSegmentAssembly-1:Joint-3]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(8).translation = [0 0 0];  % mm
smiData.RigidTransform(8).angle = 0.0;  % rad
smiData.RigidTransform(8).axis = [0 0 0];
smiData.RigidTransform(8).ID = 'B[Joint-3:ArmSegmentAssembly-2]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(9).translation = [0 0 0];  % mm
smiData.RigidTransform(9).angle = 0.0;  % rad
smiData.RigidTransform(9).axis = [0 0 0];
smiData.RigidTransform(9).ID = '[ArmSegmentAssembly-2:Joint-4]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(10).translation = [0 0 0];  % mm
smiData.RigidTransform(10).angle = 0.0;  % rad
smiData.RigidTransform(10).axis = [0 0 0];
smiData.RigidTransform(10).ID = '[Joint-4:ArmSegmentAssembly-3]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(11).translation = [0 0 0];  % mm
smiData.RigidTransform(11).angle = 90.0*pi/180;  % rad
smiData.RigidTransform(11).axis = [1 0 0];
smiData.RigidTransform(11).ID = '[ArmSegmentAssembly-3:Joint-5]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(12).translation = [0 0 0];  % mm
smiData.RigidTransform(12).angle = 0.0;  % rad
smiData.RigidTransform(12).axis = [0 0 0];
smiData.RigidTransform(12).ID = 'Joint-5:ArmSegmentAssembly-4]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(13).translation = [0 0 0];  % mm
% smiData.RigidTransform(13).angle = 90.0*pi/180;  % rad
% smiData.RigidTransform(13).axis = [0 1 0];
smiData.RigidTransform(13).angles = [90.0*pi/180 0 90*pi/180];  % rad
smiData.RigidTransform(13).ID = '[ArmSegmentAssembly-4:Joint-6]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(14).translation = [0 0 0];  % mm
smiData.RigidTransform(14).angle = 0.0;  % rad
smiData.RigidTransform(14).axis = [0 0 0];
smiData.RigidTransform(14).ID = 'Joint-6:Gripper-4]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(15).translation = [0 0 0];  % mm
% smiData.RigidTransform(15).angle = 0.0;  % rad
% smiData.RigidTransform(15).axis = [0 0 0];
smiData.RigidTransform(15).angles = [0.0 -90.0*pi/180 90*pi/180];  % rad
smiData.RigidTransform(15).ID = '[Gripper:Gripper-Attach]';

%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(7).mass = 0.0;
smiData.Solid(7).CoM = [0.0 0.0 0.0];
smiData.Solid(7).MoI = [0.0 0.0 0.0];
smiData.Solid(7).PoI = [0.0 0.0 0.0];
smiData.Solid(7).color = [0.0 0.0 0.0];
smiData.Solid(7).opacity = 0.0;
smiData.Solid(7).ID = '';

%Inertia Type - Custom
%Visual Properties - Simple
% Cylinder with 0.0625 m radius, 0.1 m height, 500 kg / m^3 density
smiData.Solid(1).mass = 0.613592;  % kg
smiData.Solid(1).CoM = [0 0 0];  % mm
smiData.Solid(1).MoI = [0.00111054, 0.00111054, 0.00119842]*1000*1000;  % kg*mm^2
smiData.Solid(1).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(1).color = [0 0.043137254901960784 0.59215686274509804];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = 'ArmBase';

%Inertia Type - Custom
%Visual Properties - Simple
% Rectangular solid with 0.04 m width, 0.05 m depth, 0.1 m height, 500 kg / m^3 density
smiData.Solid(2).mass = 0.1;  % kg
smiData.Solid(2).CoM = [0 0 0];  % mm
smiData.Solid(2).MoI = [9.66667e-05, 0.000104167, 3.41667e-05]*1000*1000;  % kg*mm^2
smiData.Solid(2).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(2).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = 'ArmLink-1';

%Inertia Type - Custom
% From Solidworks
smiData.Solid(3).mass = 0.82035729338221297;  % kg
smiData.Solid(3).CoM = [17.378469671809889 40.000000000000021 0];  % mm
smiData.Solid(3).MoI = [688.88077879603827 2963.8095840714004 3215.2206101712686];  % kg*mm^2
smiData.Solid(3).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(3).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = 'ArmAssembly-1';

%Inertia Type - Custom
% From Solidworks
smiData.Solid(4).mass = 0.82035729338221297;  % kg
smiData.Solid(4).CoM = [17.378469671809889 40.000000000000021 0];  % mm
smiData.Solid(4).MoI = [688.88077879603827 2963.8095840714004 3215.2206101712686];  % kg*mm^2
smiData.Solid(4).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(4).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = 'ArmAssembly-2';

%Inertia Type - Custom
% From Solidworks
smiData.Solid(5).mass = 0.82035729338221297;  % kg
smiData.Solid(5).CoM = [17.378469671809889 40.000000000000021 0];  % mm
smiData.Solid(5).MoI = [688.88077879603827 2963.8095840714004 3215.2206101712686];  % kg*mm^2
smiData.Solid(5).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(5).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(5).opacity = 1;
smiData.Solid(5).ID = 'ArmAssembly-3';

%Inertia Type - Custom
% From Solidworks
smiData.Solid(6).mass = 0.82035729338221297;  % kg
smiData.Solid(6).CoM = [17.378469671809889 40.000000000000021 0];  % mm
smiData.Solid(6).MoI = [688.88077879603827 2963.8095840714004 3215.2206101712686];  % kg*mm^2
smiData.Solid(6).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(6).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(6).opacity = 1;
smiData.Solid(6).ID = 'ArmAssembly-4';

%Inertia Type - Custom
% From Solidworks
smiData.Solid(7).mass = 0.30581725123519321;  % kg
smiData.Solid(7).CoM = [-21.962107391557787 40.227313216932608 0];  % mm
smiData.Solid(7).MoI = [284.10479761046042 405.92769832777844 519.86012486738491];  % kg*mm^2
smiData.Solid(7).PoI = [0 0 -4.3073766425925823];  % kg*mm^2
smiData.Solid(7).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(7).opacity = 1;
smiData.Solid(7).ID = 'Gripper';


%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(6).Rz.Pos = 0.0;
smiData.RevoluteJoint(6).ID = '';

smiData.RevoluteJoint(1).Rz.Pos = 90.0;  % deg
smiData.RevoluteJoint(1).ID = '[ArmBase-1:-:ArmSegmentAssembly-2:ArmSegment-1]';

smiData.RevoluteJoint(2).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(2).ID = '[ArmSegmentAssembly-2:ArmSegment-1:-:ArmSegmentAssembly-3:ArmSegment-1]';

smiData.RevoluteJoint(3).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(3).ID = '[ArmSegmentAssembly-3:ArmSegment-1:-:Gripper-2]';

smiData.RevoluteJoint(4).Rz.Pos = 0.0;
smiData.RevoluteJoint(4).ID = '';

smiData.RevoluteJoint(5).Rz.Pos = -90.0;
smiData.RevoluteJoint(5).ID = '';

smiData.RevoluteJoint(6).Rz.Pos = 0.0;
smiData.RevoluteJoint(6).ID = '';

% Zero angles for joints results in straight-arm configuration
% smiData.RevoluteJoint(1).Rz.Pos = 0.0;
% smiData.RevoluteJoint(2).Rz.Pos = 0.0;
% smiData.RevoluteJoint(3).Rz.Pos = 0.0;