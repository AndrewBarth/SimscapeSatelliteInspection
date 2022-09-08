% Simscape(TM) Multibody(TM) version: 7.5

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
smiData.RigidTransform(9).ID = "";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [2.8942322834645668e-08 -16.113949094048071 16.801180532127049];  % in
smiData.RigidTransform(1).angle = 0;  % rad
smiData.RigidTransform(1).axis = [0 0 0];
smiData.RigidTransform(1).ID = "AssemblyGround[8 - VXA-300-M.step-1:DRG.step-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [7.5795275590551185e-10 0.024904397850866143 2.9921259842518504];  % in
smiData.RigidTransform(2).angle = 0;  % rad
smiData.RigidTransform(2).axis = [0 0 0];
smiData.RigidTransform(2).ID = "AssemblyGround[8 - VXA-300-M.step-1:540 Dual Shoulder.step-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [0.17720493162334647 -18.023397873932758 16.801180474605669];  % in
smiData.RigidTransform(3).angle = 1.5707963267949796;  % rad
smiData.RigidTransform(3).axis = [1 -4.9999999999995853e-16 -4.9999999999995853e-16];
smiData.RigidTransform(3).ID = "AssemblyGround[8 - VXA-300-M.step-1:Carriage-DualRail-VX-ABS.step-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [0 0 0];  % in
smiData.RigidTransform(4).angle = 0;  % rad
smiData.RigidTransform(4).axis = [0 0 0];
smiData.RigidTransform(4).ID = "AssemblyGround[8 - VXA-300-M.step-1:540 Base.step-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [-0.1771259062255118 -18.023397913092321 16.801180557787045];  % in
smiData.RigidTransform(5).angle = 3.1415926535896697;  % rad
smiData.RigidTransform(5).axis = [6.2578950135006864e-14 0.70710678118657688 -0.70710678118651815];
smiData.RigidTransform(5).ID = "AssemblyGround[8 - VXA-300-M.step-1:Carriage-DualRail-VX-ABS.step-2]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [2.4043740157480313e-08 -2.3444881725962601 16.80118147782445];  % in
smiData.RigidTransform(6).angle = 0;  % rad
smiData.RigidTransform(6).axis = [0 0 0];
smiData.RigidTransform(6).ID = "AssemblyGround[8 - VXA-300-M.step-1:Fore - 8 - VX-300.step-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [-2.9966535433070867e-09 3.9370078740157484e-14 4.990157480314843];  % in
smiData.RigidTransform(7).angle = 0;  % rad
smiData.RigidTransform(7).axis = [0 0 0];
smiData.RigidTransform(7).ID = "AssemblyGround[8 - VXA-300-M.step-1:UA - 8 - VX-300.step-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(8).translation = [0.0063214496496063 -14.155511869736024 16.807502903430315];  % in
smiData.RigidTransform(8).angle = 0;  % rad
smiData.RigidTransform(8).axis = [0 0 0];
smiData.RigidTransform(8).ID = "AssemblyGround[8 - VXA-300-M.step-1:VX-300 - Wrist.step-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(9).translation = [0 0 0];  % in
smiData.RigidTransform(9).angle = 0;  % rad
smiData.RigidTransform(9).axis = [0 0 0];
smiData.RigidTransform(9).ID = "RootGround[8 - VXA-300-M.step-1]";


%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(7).mass = 0.0;
smiData.Solid(7).CoM = [0.0 0.0 0.0];
smiData.Solid(7).MoI = [0.0 0.0 0.0];
smiData.Solid(7).PoI = [0.0 0.0 0.0];
smiData.Solid(7).color = [0.0 0.0 0.0];
smiData.Solid(7).opacity = 0.0;
smiData.Solid(7).ID = "";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 0.19139929463118993;  % kg
smiData.Solid(1).CoM = [8.8642932774093353e-05 -2.3619121139984691 0.077290085169074985];  % in
smiData.Solid(1).MoI = [0.19467501872260165 0.46219399759314189 0.47297138088033402];  % kg*in^2
smiData.Solid(1).PoI = [-0.015284140284376942 7.0729990582303474e-05 1.3004193948680242e-06];  % kg*in^2
smiData.Solid(1).color = [0.82745098039215681 0.20392156862745098 0.47450980392156861];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = "DRG.step*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 0.22750581122900987;  % kg
smiData.Solid(2).CoM = [-2.2385420825569461e-09 -0.024904397850883414 1.1099947555718552];  % in
smiData.Solid(2).MoI = [0.22886361968368621 0.38732435418541 0.33478209925543767];  % kg*in^2
smiData.Solid(2).PoI = [0 -6.027580598213924e-12 0];  % kg*in^2
smiData.Solid(2).color = [0.26666666666666666 0.58823529411764708 0.28235294117647058];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = "540 Dual Shoulder.step*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 0.030669808943561843;  % kg
smiData.Solid(3).CoM = [-2.0348943755330327 3.7306589238159105e-10 2.2030115313720398];  % in
smiData.Solid(3).MoI = [0.03284902159843691 0.019074645466077091 0.017164637678722786];  % kg*in^2
smiData.Solid(3).PoI = [-1.4524292089319121e-10 -0.003356972951781815 -6.1808698240646998e-12];  % kg*in^2
smiData.Solid(3).color = [0.078431372549019607 0.63921568627450975 0.7803921568627451];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = "Carriage-DualRail-VX-ABS.step*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(4).mass = 1.6733840067154275;  % kg
smiData.Solid(4).CoM = [9.3361215529148975e-07 1.5885760442248891 1.1999332633032338];  % in
smiData.Solid(4).MoI = [14.597202554660111 4.3790506899514838 16.562884159927901];  % kg*in^2
smiData.Solid(4).PoI = [0.45354243237532349 -5.2039164645928591e-08 4.6788900017525861e-06];  % kg*in^2
smiData.Solid(4).color = [0.18823529411764706 0.23137254901960785 0.58823529411764708];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = "540 Base.step*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(5).mass = 0.38861921954319817;  % kg
smiData.Solid(5).CoM = [-0.0006714856068469583 -6.709861268438897 -8.2632209308899867e-10];  % in
smiData.Solid(5).MoI = [5.505143339722804 0.22509761379782936 5.6383453647647226];  % kg*in^2
smiData.Solid(5).PoI = [1.4348919018916328e-09 0 -0.0013311992222346033];  % kg*in^2
smiData.Solid(5).color = [0.90980392156862744 0.67843137254901964 0.13725490196078433];
smiData.Solid(5).opacity = 1;
smiData.Solid(5).ID = "Fore - 8 - VX-300.step*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(6).mass = 0.51309917484769318;  % kg
smiData.Solid(6).CoM = [1.2610068976359746e-07 -0.65147005515678991 8.2133665504398969];  % in
smiData.Solid(6).MoI = [9.0691143935343579 9.0290841660435674 0.83226055912364894];  % kg*in^2
smiData.Solid(6).PoI = [1.1985639864522872 -1.6156940630389374e-07 -1.9467753886017903e-08];  % kg*in^2
smiData.Solid(6).color = [0.76862745098039209 0.20784313725490194 0.15294117647058825];
smiData.Solid(6).opacity = 1;
smiData.Solid(6).ID = "UA - 8 - VX-300.step*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(7).mass = 0.068593686550646446;  % kg
smiData.Solid(7).CoM = [-0.0063214426139995726 -1.9026149372964425 0.44414568023223905];  % in
smiData.Solid(7).MoI = [0.036877866612394436 0.039582808464992771 0.042219137722446162];  % kg*in^2
smiData.Solid(7).PoI = [0.0023629765587020262 -1.915511108751695e-08 1.0994354529112345e-08];  % kg*in^2
smiData.Solid(7).color = [0.98431372549019602 0.54509803921568623 0.13725490196078433];
smiData.Solid(7).opacity = 1;
smiData.Solid(7).ID = "VX-300 - Wrist.step*:*Default";

