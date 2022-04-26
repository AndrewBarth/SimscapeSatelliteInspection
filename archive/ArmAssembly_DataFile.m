% Simscape(TM) Multibody(TM) version: 7.3

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(7).translation = [0.0 0.0 0.0];
smiData.RigidTransform(7).angle = 0.0;
smiData.RigidTransform(7).axis = [0.0 0.0 0.0];
smiData.RigidTransform(7).ID = '';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
%smiData.RigidTransform(1).translation = [225.06419540933817 -151.14947045570094 -319.47253852475887];  % mm
smiData.RigidTransform(1).translation = [-40.0 100.0 0.0];  % mm
%smiData.RigidTransform(1).angle = 2.8450577213064641;  % rad
smiData.RigidTransform(1).angle = 90*pi/180;  % rad
%smiData.RigidTransform(1).axis = [-0 -1 -0];
smiData.RigidTransform(1).axis = [-0 -0 1];
smiData.RigidTransform(1).ID = 'RootGround[ArmBase-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [-135.00000000000006 -19.999999999999989 0];  % mm
smiData.RigidTransform(2).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(2).axis = [-0.57735026918962584 -0.57735026918962584 -0.57735026918962584];
smiData.RigidTransform(2).ID = 'B[ArmBase-1:-:ArmSegmentAssembly-2:ArmSegment-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [-85.000000000002984 19.999999999999861 4.9737991503207013e-13];  % mm
smiData.RigidTransform(3).angle = 2.0943951023931957;  % rad
smiData.RigidTransform(3).axis = [-0.57735026918962573 -0.57735026918962606 -0.57735026918962551];
smiData.RigidTransform(3).ID = 'F[ArmBase-1:-:ArmSegmentAssembly-2:ArmSegment-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
%smiData.RigidTransform(4).translation = [135.00000000000003 0 0];  % mm
smiData.RigidTransform(4).translation = [0.00000000000003 0 0];  % mm
smiData.RigidTransform(4).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(4).axis = [-0.57735026918962584 -0.57735026918962584 -0.57735026918962584];
smiData.RigidTransform(4).ID = 'B[ArmSegmentAssembly-2:ArmSegment-1:-:ArmSegmentAssembly-3:ArmSegment-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [-84.999999999999972 2.8651771637076708e-14 4.2010839251815923e-12];  % mm
smiData.RigidTransform(5).angle = 2.0943951023931957;  % rad
smiData.RigidTransform(5).axis = [-0.57735026918962584 -0.57735026918962573 -0.57735026918962573];
smiData.RigidTransform(5).ID = 'F[ArmSegmentAssembly-2:ArmSegment-1:-:ArmSegmentAssembly-3:ArmSegment-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [135.00000000000011 0 0];  % mm
smiData.RigidTransform(6).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(6).axis = [-0.57735026918962584 -0.57735026918962584 -0.57735026918962584];
smiData.RigidTransform(6).ID = 'B[ArmSegmentAssembly-3:ArmSegment-1:-:Gripper-2]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [-65.000000000006025 -1.7793181429732344e-13 -2.9132252166164108e-12];  % mm
smiData.RigidTransform(7).angle = 2.0943951023931962;  % rad
smiData.RigidTransform(7).axis = [-0.57735026918962595 -0.5773502691896254 -0.57735026918962595];
smiData.RigidTransform(7).ID = 'F[ArmSegmentAssembly-3:ArmSegment-1:-:Gripper-2]';

%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(4).mass = 0.0;
smiData.Solid(4).CoM = [0.0 0.0 0.0];
smiData.Solid(4).MoI = [0.0 0.0 0.0];
smiData.Solid(4).PoI = [0.0 0.0 0.0];
smiData.Solid(4).color = [0.0 0.0 0.0];
smiData.Solid(4).opacity = 0.0;
smiData.Solid(4).ID = '';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 0.89654004214701999;  % kg
smiData.Solid(1).CoM = [-57.59619007975693 0 0];  % mm
smiData.Solid(1).MoI = [1188.945825770483 1878.3055135726672 1549.487823945319];  % kg*mm^2
smiData.Solid(1).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(1).color = [0 0.043137254901960784 0.59215686274509804];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = 'ArmBase*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 0.82035729338221286;  % kg
smiData.Solid(2).CoM = [17.378469671809881 40.000000000000014 0];  % mm
smiData.Solid(2).MoI = [688.88077879603816 2963.8095840714 3215.2206101712682];  % kg*mm^2
smiData.Solid(2).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(2).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = 'ArmSegment1*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 0.82035729338221286;  % kg
smiData.Solid(3).CoM = [17.378469671809881 40.000000000000014 0];  % mm
smiData.Solid(3).MoI = [688.88077879603816 2963.8095840714 3215.2206101712682];  % kg*mm^2
smiData.Solid(3).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(3).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = 'ArmSegment2*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(4).mass = 0.30581725123519321;  % kg
smiData.Solid(4).CoM = [-21.96210739155778 40.227313216932608 0];  % mm
smiData.Solid(4).MoI = [284.10479761046042 405.92769832777867 519.86012486738514];  % kg*mm^2
smiData.Solid(4).PoI = [0 0 -4.3073766425925939];  % kg*mm^2
smiData.Solid(4).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = 'Gripper*:*Default';


%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(3).Rz.Pos = 0.0;
smiData.RevoluteJoint(3).ID = '';

smiData.RevoluteJoint(1).Rz.Pos = 120.0;  % deg
smiData.RevoluteJoint(1).ID = '[ArmBase-1:-:ArmSegmentAssembly-2:ArmSegment-1]';

smiData.RevoluteJoint(2).Rz.Pos = 45.0;  % deg
smiData.RevoluteJoint(2).ID = '[ArmSegmentAssembly-2:ArmSegment-1:-:ArmSegmentAssembly-3:ArmSegment-1]';

smiData.RevoluteJoint(3).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(3).ID = '[ArmSegmentAssembly-3:ArmSegment-1:-:Gripper-2]';
