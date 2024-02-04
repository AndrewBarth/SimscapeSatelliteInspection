% Simscape(TM) Multibody(TM) version: 7.5

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(27).translation = [0.0 0.0 0.0];
smiData.RigidTransform(27).angle = 0.0;
smiData.RigidTransform(27).axis = [0.0 0.0 0.0];
smiData.RigidTransform(27).ID = "";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
%smiData.RigidTransform(1).translation = [0 0.070000000000000007 0];  % m
smiData.RigidTransform(1).translation = [0 0.050000000000000007 0];  % m
smiData.RigidTransform(1).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(1).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(1).ID = "B[ShoulderAssm:ShoulderBase-1:-:ShoulderAssm:ShoulderJoint_1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [-7.454373114739349e-20 0.01999999999999999 4.781934310810338e-18];  % m
smiData.RigidTransform(2).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(2).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(2).ID = "F[ShoulderAssm:ShoulderBase-1:-:ShoulderAssm:ShoulderJoint_1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [0 0.10000000000000001 -0.20000000000000015];  % m
smiData.RigidTransform(3).angle = 0;  % rad
smiData.RigidTransform(3).axis = [0 0 0];
smiData.RigidTransform(3).ID = "B[ShoulderAssm:ShoulderJoint_1-1:-:ShoulderAssm:ShoulderJoint_2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [-2.9259544436701571e-17 -5.1735670579599294e-18 5.4488284539228699e-17];  % m
smiData.RigidTransform(4).angle = 0.17500753848400113;  % rad
smiData.RigidTransform(4).axis = [-7.9399515716584712e-17 5.1564776796241913e-16 1];
smiData.RigidTransform(4).ID = "F[ShoulderAssm:ShoulderJoint_1-1:-:ShoulderAssm:ShoulderJoint_2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [0 0 -0.14999999999999999];  % m
smiData.RigidTransform(5).angle = 0;  % rad
smiData.RigidTransform(5).axis = [0 0 0];
smiData.RigidTransform(5).ID = "B[ShoulderAssm:ShoulderJoint_2-1:-:ShoulderAssm:ShoulderJoint_3-4]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [-1.3877787807814457e-17 0.079999999999999946 0.0749999999999999];  % m
smiData.RigidTransform(6).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(6).axis = [-0.097094454498072927 0.99527517145044953 1.1102230246251563e-16];
smiData.RigidTransform(6).ID = "F[ShoulderAssm:ShoulderJoint_2-1:-:ShoulderAssm:ShoulderJoint_3-4]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [0 0 0.14999999999999991];  % m
smiData.RigidTransform(7).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(7).axis = [1 0 0];
smiData.RigidTransform(7).ID = "B[ElbowAssem:ElbowJoint_2-1:-:ElbowAssem:MainLink1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(8).translation = [0 0.99999999999999978 0.070000000000000062];  % m
smiData.RigidTransform(8).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(8).axis = [-0.97337987028120854 -0.22919779259700046 0];
smiData.RigidTransform(8).ID = "F[ElbowAssem:ElbowJoint_2-1:-:ElbowAssem:MainLink1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(9).translation = [0 0 -0.12];  % m
smiData.RigidTransform(9).angle = 0;  % rad
smiData.RigidTransform(9).axis = [0 0 0];
smiData.RigidTransform(9).ID = "B[ElbowAssem:ElbowJoint_2-1:-:ElbowAssem:MainLink2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(10).translation = [7.0364720994309238e-17 0.060000000000000074 -0.049999999999999933];  % m
smiData.RigidTransform(10).angle = 0.47350311950184509;  % rad
smiData.RigidTransform(10).axis = [-0 -0 1];
smiData.RigidTransform(10).ID = "F[ElbowAssem:ElbowJoint_2-1:-:ElbowAssem:MainLink2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(11).translation = [0 0 0.11999999999999998];  % m
smiData.RigidTransform(11).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(11).axis = [1 0 0];
smiData.RigidTransform(11).ID = "B[WristAssem:WristJoint_1-1:-:WristAssem:WristJoint_2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(12).translation = [-3.7621815385247004e-17 0.07999999999999996 0.045000000000000609];  % m
smiData.RigidTransform(12).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(12).axis = [-0.99998781439606799 0.0049367053158388755 0];
smiData.RigidTransform(12).ID = "F[WristAssem:WristJoint_1-1:-:WristAssem:WristJoint_2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(13).translation = [0 0.25000000000000011 0];  % m
smiData.RigidTransform(13).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(13).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(13).ID = "B[WristAssem:WristJoint_2-1:-:WristAssem:WristJoint_3-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(14).translation = [1.222980050563649e-16 0.080000000000000002 -0.024999999999999939];  % m
smiData.RigidTransform(14).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(14).axis = [-0.7099747781624608 -0.70422710425910529 -1.1102230246251563e-16];
smiData.RigidTransform(14).ID = "F[WristAssem:WristJoint_2-1:-:WristAssem:WristJoint_3-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(15).translation = [0 0 0];  % m
smiData.RigidTransform(15).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(15).axis = [-0.57735026918962584 -0.57735026918962584 -0.57735026918962584];
smiData.RigidTransform(15).ID = "B[ShoulderAssm-1:ShoulderBase-1:-:Base-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(16).translation = [0 0.040000000000000008 0];  % m
smiData.RigidTransform(16).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(16).axis = [-0.57735026918962584 -0.57735026918962584 -0.57735026918962584];
smiData.RigidTransform(16).ID = "F[ShoulderAssm-1:ShoulderBase-1:-:Base-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(17).translation = [0 0.99999999999999978 -0.10000000000000006];  % m
smiData.RigidTransform(17).angle = 0;  % rad
smiData.RigidTransform(17).axis = [0 0 0];
smiData.RigidTransform(17).ID = "B[ElbowAssem-1:MainLink2-1:-:WristAssem-1:WristJoint_1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(18).translation = [9.3675067702747583e-17 -2.965563992290976e-16 0.020000000000000007];  % m
smiData.RigidTransform(18).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(18).axis = [0.025981376780238027 -0.99966242705255426 5.2041704279304201e-17];
smiData.RigidTransform(18).ID = "F[ElbowAssem-1:MainLink2-1:-:WristAssem-1:WristJoint_1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(19).translation = [0 0.24999999999999983 0];  % m
smiData.RigidTransform(19).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(19).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(19).ID = "B[ShoulderAssm-1:ShoulderJoint_3-4:-:ElbowAssem-1:MainLink1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(20).translation = [-3.4206578541917665e-17 0.050000000000000079 7.1253766775747351e-16];  % m
smiData.RigidTransform(20).angle = 2.0943951023931957;  % rad
smiData.RigidTransform(20).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962562];
smiData.RigidTransform(20).ID = "F[ShoulderAssm-1:ShoulderJoint_3-4:-:ElbowAssem-1:MainLink1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
%smiData.RigidTransform(21).translation = [0.22238666479279035 0.1530482556954034 0.48177292244169234];  % m
smiData.RigidTransform(21).translation = [0.0 0.0 0.0];  % m
smiData.RigidTransform(21).angle = 0;  % rad
smiData.RigidTransform(21).axis = [0 0 0];
smiData.RigidTransform(21).ID = "RootGround[Base-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(22).translation = [0 0 0];  % m
smiData.RigidTransform(22).angle = 0;  % rad
smiData.RigidTransform(22).axis = [0 0 0];
smiData.RigidTransform(22).ID = "AssemblyGround[ShoulderAssm-1:ShoulderBase-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(23).translation = [0.1785521487815529 -0.67839225746499165 0.62683347079907237];  % m
smiData.RigidTransform(23).angle = 0;  % rad
smiData.RigidTransform(23).axis = [0 0 0];
smiData.RigidTransform(23).ID = "AssemblyGround[ElbowAssem-1:MainLink1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(24).translation = [0 0 0];  % m
smiData.RigidTransform(24).angle = 0;  % rad
smiData.RigidTransform(24).axis = [0 0 0];
smiData.RigidTransform(24).ID = "AssemblyGround[WristAssem-1:WristJoint_1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(25).translation = [0 0.24999999999999994 4.4408920985006262e-16];  % m
smiData.RigidTransform(25).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(25).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(25).ID = "B[WristAssem-1:WristJoint_3-1:-:Gripper-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(26).translation = [-7.5697087487114345e-13 2.8649201067043606e-12 0.049999999997770869];  % m
smiData.RigidTransform(26).angle = 3.1415926535897927;  % rad
smiData.RigidTransform(26).axis = [-1 5.1341605930017044e-32 -1.4344517514058436e-16];
smiData.RigidTransform(26).ID = "F[WristAssem-1:WristJoint_3-1:-:Gripper-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(27).translation = [0.0 0.0 0.0];  % m
smiData.RigidTransform(27).angle = 0.0;  % rad
smiData.RigidTransform(27).axis = [1 0 0];
smiData.RigidTransform(27).ID = "[Gripper-Out]";

%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(12).mass = 0.0;
smiData.Solid(12).CoM = [0.0 0.0 0.0];
smiData.Solid(12).MoI = [0.0 0.0 0.0];
smiData.Solid(12).PoI = [0.0 0.0 0.0];
smiData.Solid(12).color = [0.0 0.0 0.0];
smiData.Solid(12).opacity = 0.0;
smiData.Solid(12).ID = "";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 6.3617251235193324;  % kg
smiData.Solid(1).CoM = [0 0.02 0];  % m
smiData.Solid(1).MoI = [0.081363813611010832 0.16103116718908317 0.081363813611010832];  % kg*m^2
smiData.Solid(1).PoI = [0 0 0];  % kg*m^2
smiData.Solid(1).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = "Base*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 3.4660361982382968;  % kg
smiData.Solid(2).CoM = [-1.762374680286557e-08 0.10302240844746322 -0.00083820275029878363];  % m
smiData.Solid(2).MoI = [0.017469211001944498 0.009753990283584632 0.017641930379461258];  % kg*m^2
smiData.Solid(2).PoI = [-6.6890329452675771e-05 1.5852914365528228e-09 7.7316838197911073e-10];  % kg*m^2
smiData.Solid(2).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = "ShoulderJoint_3*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 6.3083180484083057;  % kg
smiData.Solid(3).CoM = [0 0.025139442231075698 0];  % m
smiData.Solid(3).MoI = [0.064174865991167784 0.12566873269183748 0.064174865991167798];  % kg*m^2
smiData.Solid(3).PoI = [0 0 0];  % kg*m^2
smiData.Solid(3).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = "ShoulderBase*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(4).mass = 4.1381616758511743;  % kg
smiData.Solid(4).CoM = [-1.1385087519563715e-07 0.03917147018874137 2.8524373126653656e-07];  % m
smiData.Solid(4).MoI = [0.022796837204074501 0.054755567999538929 0.038625881234977961];  % kg*m^2
smiData.Solid(4).PoI = [-7.0801431862771522e-08 -1.6635131285887796e-07 -1.2502252284318782e-07];  % kg*m^2
smiData.Solid(4).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = "ShoulderJoint_1*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(5).mass = 7.2256631032565277;  % kg
smiData.Solid(5).CoM = [0 0 0.1684782608695653];  % m
smiData.Solid(5).MoI = [0.094943141546852614 0.094943141546852614 0.022556635252774734];  % kg*m^2
smiData.Solid(5).PoI = [0 0 0];  % kg*m^2
smiData.Solid(5).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(5).opacity = 1;
smiData.Solid(5).ID = "ShoulderJoint_2*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(6).mass = 14.621004504510454;  % kg
smiData.Solid(6).CoM = [-1.0164751503329631e-07 0.47902955866663821 1.4935091827729534e-07];  % m
smiData.Solid(6).MoI = [1.1204490701366563 0.036168474953205479 1.1208606613874808];  % kg*m^2
smiData.Solid(6).PoI = [-6.5702308561883529e-07 1.1907922592522587e-07 3.9235984837131487e-07];  % kg*m^2
smiData.Solid(6).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(6).opacity = 1;
smiData.Solid(6).ID = "MainLink1*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(7).mass = 1.8472564803107978;  % kg
smiData.Solid(7).CoM = [0 0 0.063979591836734684];  % m
smiData.Solid(7).MoI = [0.0074276290424008691 0.0074276290424008691 0.0030837873487637407];  % kg*m^2
smiData.Solid(7).PoI = [0 0 0];  % kg*m^2
smiData.Solid(7).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(7).opacity = 1;
smiData.Solid(7).ID = "ElbowJoint_2*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(8).mass = 14.509793456558047;  % kg
smiData.Solid(8).CoM = [-9.3106143578466106e-08 0.48209127653333722 -1.1075619333773679e-07];  % m
smiData.Solid(8).MoI = [1.1024226134191359 0.035885374942965897 1.1030951197547119];  % kg*m^2
smiData.Solid(8).PoI = [-4.5026053427592939e-07 1.1796280975003132e-07 3.5507215006783202e-07];  % kg*m^2
smiData.Solid(8).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(8).opacity = 1;
smiData.Solid(8).ID = "MainLink2*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(9).mass = 1.8472564803107978;  % kg
smiData.Solid(9).CoM = [0 0 -0.063979591836734684];  % m
smiData.Solid(9).MoI = [0.0074276290424008726 0.0074276290424008726 0.0030837873487637403];  % kg*m^2
smiData.Solid(9).PoI = [0 0 0];  % kg*m^2
smiData.Solid(9).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(9).opacity = 1;
smiData.Solid(9).ID = "WristJoint_1*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(10).mass = 3.4786097987600129;  % kg
smiData.Solid(10).CoM = [-3.7363733374716517e-09 0.10293930416964057 0.00092535595020164718];  % m
smiData.Solid(10).MoI = [0.017484562071174981 0.0097626803833646345 0.017651074643667518];  % kg*m^2
smiData.Solid(10).PoI = [7.3870043062516548e-05 2.0594435892735263e-09 -7.569569010258609e-10];  % kg*m^2
smiData.Solid(10).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(10).opacity = 1;
smiData.Solid(10).ID = "WristJoint_2*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(11).mass = 3.4786097987600129;  % kg
smiData.Solid(11).CoM = [-3.7363733374716517e-09 0.10293930416964057 0.00092535595020164718];  % m
smiData.Solid(11).MoI = [0.017484562071174981 0.0097626803833646345 0.017651074643667518];  % kg*m^2
smiData.Solid(11).PoI = [7.3870043062516548e-05 2.0594435892735263e-09 -7.569569010258609e-10];  % kg*m^2
smiData.Solid(11).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(11).opacity = 1;
smiData.Solid(11).ID = "WristJoint_3*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(12).mass = 4.3542032210398034;  % kg
smiData.Solid(12).CoM = [0 0 0.050341701282958215];  % m
smiData.Solid(12).MoI = [0.034944012748999727 0.043424731550466132 0.049044172251994325];  % kg*m^2
smiData.Solid(12).PoI = [0 0 0];  % kg*m^2
smiData.Solid(12).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(12).opacity = 1;
smiData.Solid(12).ID = "Gripper*:*Default";


%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(7).Rz.Pos = 0.0;
smiData.RevoluteJoint(7).ID = "";

% smiData.RevoluteJoint(1).Rz.Pos = 87.960647595565831;  % deg
smiData.RevoluteJoint(1).Rz.Pos = 90.0;  % deg
smiData.RevoluteJoint(1).ID = "[ShoulderAssm-1:ShoulderBase-1:-:ShoulderAssm-1:ShoulderJoint_1-1]";

smiData.RevoluteJoint(2).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(2).ID = "[ShoulderAssm-1:ShoulderBase-1:-:Base-1]";

% smiData.RevoluteJoint(3).Rz.Pos = 1.4699495555125186;  % deg
smiData.RevoluteJoint(3).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(3).ID = "[ShoulderAssm-1:ShoulderJoint_3-4:-:ElbowAssem-1:MainLink1-1]";

smiData.RevoluteJoint(4).Rz.Pos = 0.0;
smiData.RevoluteJoint(4).ID = "";

smiData.RevoluteJoint(5).Rz.Pos = 0.0;
smiData.RevoluteJoint(5).ID = "";

smiData.RevoluteJoint(6).Rz.Pos = 0.0;
smiData.RevoluteJoint(6).ID = "";

smiData.RevoluteJoint(7).Rz.Pos = 0.0;
smiData.RevoluteJoint(7).ID = "";