% Simscape(TM) Multibody(TM) version: 7.3

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(13).translation = [0.0 0.0 0.0];
smiData.RigidTransform(13).angle = 0.0;
smiData.RigidTransform(13).axis = [0.0 0.0 0.0];
smiData.RigidTransform(13).ID = '';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [-85 80.000000000000014 0];  % mm
smiData.RigidTransform(1).angle = 2.0943951023931953;  % rad
%smiData.RigidTransform(1).angle = 0*pi/180;  % rad
smiData.RigidTransform(1).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(1).ID = 'B[ArmSegmentAssembly:ArmSegment-1:-:ArmSegmentAssembly:ArmAttachPin-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [6.4659388954169117e-13 1.4637180356658064e-12 -39.999999999999766];  % mm
smiData.RigidTransform(2).angle = 4.6526822989446144e-16;  % rad
smiData.RigidTransform(2).axis = [-0.47704119032657494 -0.87888093774515585 9.7534739377937152e-17];
smiData.RigidTransform(2).ID = 'F[ArmSegmentAssembly:ArmSegment-1:-:ArmSegmentAssembly:ArmAttachPin-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [135 0 0];  % mm
smiData.RigidTransform(3).angle = 2.0943951023931953;  % rad
%smiData.RigidTransform(3).angle = 0*pi/180;  % rad
smiData.RigidTransform(3).axis = [-0.57735026918962584 -0.57735026918962584 -0.57735026918962584];
smiData.RigidTransform(3).ID = 'B[ArmSegmentAssembly-1:ArmSegment-1:-:ArmSegmentAssembly-2:ArmAttachPin-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [-5.7553961596568115e-12 -6.6577854340721387e-12 40.00000000000032];  % mm
smiData.RigidTransform(4).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(4).axis = [-1 7.4278308235061505e-33 -1.903291342857688e-16];
smiData.RigidTransform(4).ID = 'F[ArmSegmentAssembly-1:ArmSegment-1:-:ArmSegmentAssembly-2:ArmAttachPin-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [-135.00000000000006 -19.999999999999989 0];  % mm
smiData.RigidTransform(5).angle = 2.0943951023931953;  % rad
%smiData.RigidTransform(5).angle = 0*pi/180;  % rad
smiData.RigidTransform(5).axis = [-0.57735026918962584 -0.57735026918962584 -0.57735026918962584];
smiData.RigidTransform(5).ID = 'B[ArmBase-1:-:ArmSegmentAssembly-1:ArmAttachPin-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [-3.8191672047105385e-14 1.2434497875801753e-13 19.99999999999989];  % mm
smiData.RigidTransform(6).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(6).axis = [-1 1.3298026299934645e-33 -5.0909521454284213e-17];
smiData.RigidTransform(6).ID = 'F[ArmBase-1:-:ArmSegmentAssembly-1:ArmAttachPin-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [135.00000000000011 0 1.1102230246251565e-13];  % mm
smiData.RigidTransform(7).angle = 2.0943951023931953;  % rad
%smiData.RigidTransform(7).angle = 0*pi/180;  % rad
smiData.RigidTransform(7).axis = [-0.57735026918962584 -0.57735026918962584 -0.57735026918962584];
smiData.RigidTransform(7).ID = 'B[ArmSegmentAssembly-3:ArmSegment-1:-:ArmAttachPin-8]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(8).translation = [-1.3677947663381929e-13 7.1054273576010019e-15 40.000000000000455];  % mm
smiData.RigidTransform(8).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(8).axis = [-1 -1.5975638796558932e-33 4.4658474666042865e-17];
smiData.RigidTransform(8).ID = 'F[ArmSegmentAssembly-3:ArmSegment-1:-:ArmAttachPin-8]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(9).translation = [-65.000000000000171 89.999999999999986 0];  % mm
smiData.RigidTransform(9).angle = 2.0943951023931953;  % rad
%smiData.RigidTransform(9).angle = 0*pi/180;  % rad
smiData.RigidTransform(9).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(9).ID = 'B[Gripper-2:-:ArmAttachPin-8]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(10).translation = [-3.0695446184836328e-12 1.9468870959826745e-12 -49.999999999999993];  % mm
smiData.RigidTransform(10).angle = 8.3266726846886753e-17;  % rad
smiData.RigidTransform(10).axis = [0.95317256920266635 0.30242693881264665 1.2001444099524807e-17];
smiData.RigidTransform(10).ID = 'F[Gripper-2:-:ArmAttachPin-8]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(11).translation = [134.99999999999977 0 0];  % mm
smiData.RigidTransform(11).angle = 2.0943951023931953;  % rad
%smiData.RigidTransform(11).angle = 0*pi/180;  % rad
smiData.RigidTransform(11).axis = [-0.57735026918962584 -0.57735026918962584 -0.57735026918962584];
smiData.RigidTransform(11).ID = 'B[ArmSegmentAssembly-2:ArmSegment-1:-:ArmSegmentAssembly-3:ArmAttachPin-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(12).translation = [-1.6875389974302379e-13 -1.4210854715202004e-13 39.999999999999929];  % mm
smiData.RigidTransform(12).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(12).axis = [-1 2.1237168920766891e-33 -2.5575900486339036e-16];
smiData.RigidTransform(12).ID = 'F[ArmSegmentAssembly-2:ArmSegment-1:-:ArmSegmentAssembly-3:ArmAttachPin-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
%smiData.RigidTransform(13).translation = [225.06419540933817 -151.14947045570094 -319.47253852475887];  % mm
smiData.RigidTransform(13).translation = [0.0 0.0 0.0];  % mm
%smiData.RigidTransform(13).angle = 2.8450577213064641;  % rad
smiData.RigidTransform(13).angle = 90.0*pi/180;  % rad
%smiData.RigidTransform(13).axis = [-0 -1 -0];
smiData.RigidTransform(13).axis = [-0 -0  1];
smiData.RigidTransform(13).ID = 'RootGround[ArmBase-1]';


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
smiData.Solid(1).mass = 0.014137166941154067;  % kg
smiData.Solid(1).CoM = [0 0 0];  % mm
smiData.Solid(1).MoI = [7.7386262787254854 7.7386262787254854 0.39760782021995816];  % kg*mm^2
smiData.Solid(1).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(1).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = 'ArmAttachPin*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 0.80622012644105889;  % kg
smiData.Solid(2).CoM = [19.173688458172045 40.000000000000014 0];  % mm
smiData.Solid(2).MoI = [681.14215251731287 2812.6370719739093 3056.7070796152716];  % kg*mm^2
smiData.Solid(2).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(2).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = 'ArmSegment*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 0.29168008429403913;  % kg
smiData.Solid(3).CoM = [-19.876144360953138 40.238330646879824 0];  % mm
smiData.Solid(3).MoI = [276.36540544073455 378.07520827440447 484.66585046450501];  % kg*mm^2
smiData.Solid(3).PoI = [0 0 -4.162368204152];  % kg*mm^2
smiData.Solid(3).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = 'Gripper*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(4).mass = 0.89654004214701988;  % kg
smiData.Solid(4).CoM = [-57.596190079756937 0 0];  % mm
smiData.Solid(4).MoI = [1188.945825770483 1878.3055135726665 1549.4878239453187];  % kg*mm^2
smiData.Solid(4).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(4).color = [0 0.043137254901960784 0.59215686274509804];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = 'ArmBase*:*Default';


%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the CylindricalJoint structure array by filling in null values.
smiData.CylindricalJoint(4).Rz.Pos = 0.0;
smiData.CylindricalJoint(4).Pz.Pos = 0.0;
smiData.CylindricalJoint(4).ID = '';

%smiData.CylindricalJoint(1).Rz.Pos = -156.82468078615005;  % deg
smiData.CylindricalJoint(1).Rz.Pos = 0.0;  % deg
smiData.CylindricalJoint(1).Pz.Pos = 0;  % mm
smiData.CylindricalJoint(1).ID = '[ArmSegmentAssembly-1:ArmSegment-1:-:ArmSegmentAssembly-2:ArmAttachPin-1]';

%smiData.CylindricalJoint(2).Rz.Pos = 26.250853834906614;  % deg
smiData.CylindricalJoint(2).Rz.Pos = 0.0;  % deg
smiData.CylindricalJoint(2).Pz.Pos = 0;  % mm
smiData.CylindricalJoint(2).ID = '[ArmBase-1:-:ArmSegmentAssembly-1:ArmAttachPin-1]';

%smiData.CylindricalJoint(3).Rz.Pos = -105.46425272560388;  % deg
smiData.CylindricalJoint(3).Rz.Pos = 0.0;  % mm
smiData.CylindricalJoint(3).Pz.Pos = 0;  % mm
smiData.CylindricalJoint(3).ID = '[ArmSegmentAssembly-3:ArmSegment-1:-:ArmAttachPin-8]';

%smiData.CylindricalJoint(4).Rz.Pos = 158.66145892575801;  % deg
smiData.CylindricalJoint(4).Rz.Pos = 0.0;  % deg
smiData.CylindricalJoint(4).Pz.Pos = 0;  % mm
smiData.CylindricalJoint(4).ID = '[ArmSegmentAssembly-2:ArmSegment-1:-:ArmSegmentAssembly-3:ArmAttachPin-1]';


%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(4).Rz.Pos = 0.0;
smiData.RevoluteJoint(4).ID = '';

%smiData.RevoluteJoint(1).Rz.Pos = 118.13946475962541;  % deg
smiData.RevoluteJoint(1).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(1).ID = '[ArmSegmentAssembly-3:ArmSegment-1:-:ArmSegmentAssembly-3:ArmAttachPin-1]';

%smiData.RevoluteJoint(2).Rz.Pos = 156.82468078615005;  % deg
smiData.RevoluteJoint(2).Rz.Pos = 180.0;  % deg
smiData.RevoluteJoint(2).ID = '[ArmSegmentAssembly-1:ArmSegment-1:-:ArmSegmentAssembly-1:ArmAttachPin-1]';

%smiData.RevoluteJoint(3).Rz.Pos = -157.72337900665724;  % deg
smiData.RevoluteJoint(3).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(3).ID = '[ArmSegmentAssembly-2:ArmSegment-1:-:ArmSegmentAssembly-2:ArmAttachPin-1]';

%smiData.RevoluteJoint(4).Rz.Pos = 144.7931416780828;  % deg
smiData.RevoluteJoint(4).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(4).ID = '[Gripper-2:-:ArmAttachPin-8]';

