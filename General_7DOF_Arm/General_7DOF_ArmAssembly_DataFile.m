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
smiData.RigidTransform(1).translation = [0 0 -0.12];  % m
smiData.RigidTransform(1).angle = 0;  % rad
smiData.RigidTransform(1).axis = [0 0 0];
smiData.RigidTransform(1).ID = "B[ElbowAssem:ElbowJoint_1-1:-:ElbowAssem:ElbowJoint_2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [1.2349062744609896e-16 0.080000000000000279 -0.044999999999999818];  % m
smiData.RigidTransform(2).angle = 0.45225325209315398;  % rad
smiData.RigidTransform(2).axis = [-0 -0 1];
smiData.RigidTransform(2).ID = "F[ElbowAssem:ElbowJoint_1-1:-:ElbowAssem:ElbowJoint_2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [0 0 0.14999999999999991];  % m
smiData.RigidTransform(3).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(3).axis = [1 0 0];
smiData.RigidTransform(3).ID = "B[ElbowAssem:ElbowJoint_1-1:-:ElbowAssem:MainLink1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [-1.1102230246251565e-16 1 0.070000000000000062];  % m
smiData.RigidTransform(4).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(4).axis = [-0.97337986966759837 -0.22919779520294103 0];
smiData.RigidTransform(4).ID = "F[ElbowAssem:ElbowJoint_1-1:-:ElbowAssem:MainLink1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [0 0.11999999999999994 0];  % m
smiData.RigidTransform(5).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(5).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(5).ID = "B[ElbowAssem:MainLink2-1:-:ElbowAssem:ElbowJoint_2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [-2.1684043449710089e-17 0.31999999999999956 2.2204460492503131e-16];  % m
smiData.RigidTransform(6).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(6).axis = [0.57735026918962584 -0.57735026918962595 0.57735026918962562];
smiData.RigidTransform(6).ID = "F[ElbowAssem:MainLink2-1:-:ElbowAssem:ElbowJoint_2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [0 0 0.11999999999999998];  % m
smiData.RigidTransform(7).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(7).axis = [1 0 0];
smiData.RigidTransform(7).ID = "B[WristAssem:WristJoint_1-1:-:WristAssem:WristJoint_2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(8).translation = [-5.5430083266416741e-12 0.080000000000012492 0.045000000006090168];  % m
smiData.RigidTransform(8).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(8).axis = [0.99992324121868681 -0.01238998267617589 -2.3333821827614919e-16];
smiData.RigidTransform(8).ID = "F[WristAssem:WristJoint_1-1:-:WristAssem:WristJoint_2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
% smiData.RigidTransform(9).translation = [0 0.070000000000000007 0];  % m
smiData.RigidTransform(9).translation = [0 0.050000000000000007 0];  % m
smiData.RigidTransform(9).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(9).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(9).ID = "B[ShoulderAssm:ShoulderBase-1:-:ShoulderAssm:ShoulderJoint_1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
% smiData.RigidTransform(10).translation = [4.7685483151555724e-18 0.01999999999999999 8.546573737368977e-20];  % m
smiData.RigidTransform(10).translation = [0 0 0];  % m
smiData.RigidTransform(10).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(10).axis = [0.57735026918962584 -0.57735026918962595 0.57735026918962562];
smiData.RigidTransform(10).ID = "F[ShoulderAssm:ShoulderBase-1:-:ShoulderAssm:ShoulderJoint_1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(11).translation = [0 0.10000000000000001 -0.20000000000000015];  % m
% smiData.RigidTransform(11).translation = [0 0.10000000000000001 -0.27500000000000015];  % m  Added 1/2 dia of shoulder link 3
smiData.RigidTransform(11).angle = 0;  % rad
smiData.RigidTransform(11).axis = [0 0 0];
smiData.RigidTransform(11).ID = "B[ShoulderAssm:ShoulderJoint_1-1:-:ShoulderAssm:ShoulderJoint_2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(12).translation = [-1.2352387442382618e-18 -1.6933508304249615e-16 8.2226606478443507e-17];  % m
smiData.RigidTransform(12).angle = 0.1750075384851833;  % rad
smiData.RigidTransform(12).axis = [-2.3819854714814917e-16 6.330594822940556e-16 1];
smiData.RigidTransform(12).ID = "F[ShoulderAssm:ShoulderJoint_1-1:-:ShoulderAssm:ShoulderJoint_2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(13).translation = [0 0 -0.14999999999999999];  % m
smiData.RigidTransform(13).angle = 0;  % rad
smiData.RigidTransform(13).axis = [0 0 0];
smiData.RigidTransform(13).ID = "B[ShoulderAssm:ShoulderJoint_2-1:-:ShoulderAssm:ShoulderJoint_3-4]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(14).translation = [-9.7144514654701197e-17 0.080000000000000002 0.07500000000000008];  % m
smiData.RigidTransform(14).angle = 3.1415926535897927;  % rad
smiData.RigidTransform(14).axis = [-0.097094454498072955 0.99527517145044964 6.2450045135165055e-17];
smiData.RigidTransform(14).ID = "F[ShoulderAssm:ShoulderJoint_2-1:-:ShoulderAssm:ShoulderJoint_3-4]";

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
smiData.RigidTransform(17).translation = [0 0.24999999999999956 0];  % m
smiData.RigidTransform(17).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(17).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(17).ID = "B[WristAssem-1:WristJoint_2-1:-:Gripper-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(18).translation = [5.5806399540565821e-12 0.049999999999987839 6.055878969948511e-12];  % m
smiData.RigidTransform(18).angle = 2.0943951023931948;  % rad
smiData.RigidTransform(18).axis = [0.5773502691896254 -0.57735026918962562 0.57735026918962618];
smiData.RigidTransform(18).ID = "F[WristAssem-1:WristJoint_2-1:-:Gripper-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(19).translation = [0 1 -0.10000000000000001];  % m
smiData.RigidTransform(19).angle = 0;  % rad
smiData.RigidTransform(19).axis = [0 0 0];
smiData.RigidTransform(19).ID = "B[ElbowAssem-1:MainLink2-1:-:WristAssem-1:WristJoint_1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(20).translation = [4.8225312632155237e-16 -6.2059732353070274e-16 0.019999999999999969];  % m
smiData.RigidTransform(20).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(20).axis = [-0.015358763086539077 0.9998820472417993 1.3010426069826053e-18];
smiData.RigidTransform(20).ID = "F[ElbowAssem-1:MainLink2-1:-:WristAssem-1:WristJoint_1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(21).translation = [0 0.25000000000000011 0];  % m
smiData.RigidTransform(21).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(21).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(21).ID = "B[ShoulderAssm-1:ShoulderJoint_3-4:-:ElbowAssem-1:MainLink1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(22).translation = [1.0245710529988017e-16 0.050000000000000148 1.7780915628762273e-16];  % m
smiData.RigidTransform(22).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(22).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(22).ID = "F[ShoulderAssm-1:ShoulderJoint_3-4:-:ElbowAssem-1:MainLink1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(23).translation = [0.17855214878155279 -0.67839225746499188 0.62683347079907203];  % m
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
smiData.RigidTransform(25).translation = [0 0 0];  % m
% smiData.RigidTransform(25).angle = 0;  % rad
% smiData.RigidTransform(25).axis = [0 0 0];
smiData.RigidTransform(25).angle = -pi/2;  % rad
smiData.RigidTransform(25).axis = [0 1 0];
smiData.RigidTransform(25).ID = "AssemblyGround[ShoulderAssm-1:ShoulderBase-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
% smiData.RigidTransform(26).translation = [0.22238666479279035 0.1530482556954034 0.48177292244169234];  % m
smiData.RigidTransform(26).translation = [0 0 0];  % m
smiData.RigidTransform(26).angle = 0;  % rad
smiData.RigidTransform(26).axis = [0 0 0];
smiData.RigidTransform(26).ID = "RootGround[Base-1]";

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
smiData.Solid(1).mass = 14.621004504510452;  % kg
smiData.Solid(1).CoM = [-1.0164751503329632e-07 0.47902955866663821 1.4935091827729537e-07];  % m
smiData.Solid(1).MoI = [1.1204490701366563 0.036168474953205479 1.1208606613874808];  % kg*m^2
smiData.Solid(1).PoI = [-6.5702308561883519e-07 1.1907922592522587e-07 3.9235984837131487e-07];  % kg*m^2
smiData.Solid(1).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = "MainLink1*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 3.4409015070309521;  % kg
smiData.Solid(2).CoM = [1.5140174561662542e-08 0.10319060614411574 -0.00055217217572646059];  % m
smiData.Solid(2).MoI = [0.017413609232196998 0.0097118110776353572 0.017623481075638159];  % kg*m^2
smiData.Solid(2).PoI = [-4.4067821437534119e-05 -1.8583408497693676e-09 8.4948966494741829e-10];  % kg*m^2
smiData.Solid(2).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = "ElbowJoint_2*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 14.533039910209936;  % kg
smiData.Solid(3).CoM = [-1.02262760190318e-07 0.48141451394679063 1.5025489934496922e-07];  % m
smiData.Solid(3).MoI = [1.1066643699711496 0.036150882034342489 1.1070759612219752];  % kg*m^2
smiData.Solid(3).PoI = [-6.5181515310121617e-07 1.1907922458173933e-07 3.8881535460466002e-07];  % kg*m^2
smiData.Solid(3).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = "MainLink2*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(4).mass = 1.8472564803107978;  % kg
smiData.Solid(4).CoM = [0 0 0.063979591836734684];  % m
smiData.Solid(4).MoI = [0.0074276290424008726 0.0074276290424008726 0.0030837873487637403];  % kg*m^2
smiData.Solid(4).PoI = [0 0 0];  % kg*m^2
smiData.Solid(4).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = "ElbowJoint_1*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(5).mass = 1.8472564803107978;  % kg
smiData.Solid(5).CoM = [0 0 -0.063979591836734684];  % m
smiData.Solid(5).MoI = [0.0074276290424008726 0.0074276290424008726 0.0030837873487637403];  % kg*m^2
smiData.Solid(5).PoI = [0 0 0];  % kg*m^2
smiData.Solid(5).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(5).opacity = 1;
smiData.Solid(5).ID = "WristJoint_1*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(6).mass = 3.4786097987600129;  % kg
smiData.Solid(6).CoM = [-3.7363733374119665e-09 0.10293930416964057 0.00092535595020164696];  % m
smiData.Solid(6).MoI = [0.017484562071174978 0.0097626803833646345 0.017651074643667514];  % kg*m^2
smiData.Solid(6).PoI = [7.3870043062516615e-05 2.0594435892801355e-09 -7.5695690103369823e-10];  % kg*m^2
smiData.Solid(6).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(6).opacity = 1;
smiData.Solid(6).ID = "WristJoint_2*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(7).mass = 4.1381616758511743;  % kg
smiData.Solid(7).CoM = [-1.1385087519563715e-07 0.03917147018874137 2.8524373126653656e-07];  % m
smiData.Solid(7).MoI = [0.022796837204074501 0.054755567999538929 0.038625881234977961];  % kg*m^2
smiData.Solid(7).PoI = [-7.0801431862771522e-08 -1.6635131285887793e-07 -1.2502252284318782e-07];  % kg*m^2
smiData.Solid(7).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(7).opacity = 1;
smiData.Solid(7).ID = "ShoulderJoint_1*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(8).mass = 7.2256631032565277;  % kg
smiData.Solid(8).CoM = [0 0 0.1684782608695653];  % m
smiData.Solid(8).MoI = [0.094943141546852614 0.094943141546852614 0.022556635252774734];  % kg*m^2
smiData.Solid(8).PoI = [0 0 0];  % kg*m^2
smiData.Solid(8).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(8).opacity = 1;
smiData.Solid(8).ID = "ShoulderJoint_2*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(9).mass = 6.3083180484083057;  % kg
smiData.Solid(9).CoM = [0 0.025139442231075698 0];  % m
smiData.Solid(9).MoI = [0.064174865991167784 0.12566873269183748 0.064174865991167798];  % kg*m^2
smiData.Solid(9).PoI = [0 0 0];  % kg*m^2
smiData.Solid(9).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(9).opacity = 1;
smiData.Solid(9).ID = "ShoulderBase*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(10).mass = 3.4660361982382963;  % kg
smiData.Solid(10).CoM = [-1.7623746802865574e-08 0.10302240844746322 -0.00083820275029878374];  % m
smiData.Solid(10).MoI = [0.017469211001944498 0.009753990283584632 0.017641930379461258];  % kg*m^2
smiData.Solid(10).PoI = [-6.6890329452675757e-05 1.5852914365528228e-09 7.7316838197911114e-10];  % kg*m^2
smiData.Solid(10).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(10).opacity = 1;
smiData.Solid(10).ID = "ShoulderJoint_3*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(11).mass = 6.3617251235193333;  % kg
smiData.Solid(11).CoM = [0 0.02 0];  % m
smiData.Solid(11).MoI = [0.081363813611010832 0.16103116718908317 0.081363813611010818];  % kg*m^2
smiData.Solid(11).PoI = [0 0 0];  % kg*m^2
smiData.Solid(11).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(11).opacity = 1;
smiData.Solid(11).ID = "Base*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(12).mass = 4.3542032210398034;  % kg
smiData.Solid(12).CoM = [0 0.050341701282958201 0];  % m
smiData.Solid(12).MoI = [0.034944012748999734 0.049044172251994325 0.043424731550466125];  % kg*m^2
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

% smiData.RevoluteJoint(1).Rz.Pos = 90.0;  % deg
smiData.RevoluteJoint(1).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(1).ID = "[Shoulder-1:Joint-1]";

smiData.RevoluteJoint(2).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(2).ID = "[Shoulder-2:Joint-2]";

smiData.RevoluteJoint(3).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(3).ID = "[Shoulder-3:Joint-3]";

% smiData.RevoluteJoint(4).Rz.Pos = -95.03088396129948;  % deg
smiData.RevoluteJoint(4).Rz.Pos = 20.0;  % deg
smiData.RevoluteJoint(4).ID = "[Elbow-1:Joint-4]";

smiData.RevoluteJoint(5).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(5).ID = "[Elbow-2:Joint-5]";

% smiData.RevoluteJoint(6).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(6).Rz.Pos = -20.0;  % deg
smiData.RevoluteJoint(6).ID = "[Wrist-1:Joint-6]";

smiData.RevoluteJoint(7).Rz.Pos = 90.0;  % deg
% smiData.RevoluteJoint(7).Rz.Pos = -45.0;  % deg
% smiData.RevoluteJoint(7).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(7).ID = "[Wrist-2:Joint-7]";

