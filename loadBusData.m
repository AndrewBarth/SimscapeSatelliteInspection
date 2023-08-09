

%% Geometry Bus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'rBase';
elems(1).Dimensions = [1 3];
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real'; 

elems(2) = Simulink.BusElement;
elems(2).Name = 'rVec';
elems(2).Dimensions = [nLink,3];
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real';

elems(3) = Simulink.BusElement;
elems(3).Name = 'rVec0';
elems(3).Dimensions = [nLink,3];
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).SampleTime = -1;
elems(3).Complexity = 'real';

elems(4) = Simulink.BusElement;
elems(4).Name = 'pVec';
elems(4).Dimensions = [nLink+1,3];
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).SampleTime = -1;
elems(4).Complexity = 'real';

elems(5) = Simulink.BusElement;
elems(5).Name = 'RL';
elems(5).Dimensions = [nLink,3,3];
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'double';
elems(5).SampleTime = -1;
elems(5).Complexity = 'real';

elems(6) = Simulink.BusElement;
elems(6).Name = 'RLbase';
elems(6).Dimensions = [3,3];
elems(6).DimensionsMode = 'Fixed';
elems(6).DataType = 'double';
elems(6).SampleTime = -1;
elems(6).Complexity = 'real';

elems(7) = Simulink.BusElement;
elems(7).Name = 'RJ';
elems(7).Dimensions = [nLink+1,3,3];
elems(7).DimensionsMode = 'Fixed';
elems(7).DataType = 'double';
elems(7).SampleTime = -1;
elems(7).Complexity = 'real';

elems(8) = Simulink.BusElement;
elems(8).Name = 'RJbase';
elems(8).Dimensions = [3,3];
elems(8).DimensionsMode = 'Fixed';
elems(8).DataType = 'double';
elems(8).SampleTime = -1;
elems(8).Complexity = 'real';

elems(9) = Simulink.BusElement;
elems(9).Name = 'kVec';
elems(9).Dimensions = [nLink,3];
elems(9).DimensionsMode = 'Fixed';
elems(9).DataType = 'double';
elems(9).SampleTime = -1;
elems(9).Complexity = 'real';

elems(10) = Simulink.BusElement;
elems(10).Name = 'T00';
elems(10).Dimensions = [4,4];
elems(10).DimensionsMode = 'Fixed';
elems(10).DataType = 'double';
elems(10).SampleTime = -1;
elems(10).Complexity = 'real';

elems(11) = Simulink.BusElement;
elems(11).Name = 'PoseMats';
elems(11).Dimensions = [4,4,nLink+1];
elems(11).DimensionsMode = 'Fixed';
elems(11).DataType = 'double';
elems(11).SampleTime = -1;
elems(11).Complexity = 'real';

elems(12) = Simulink.BusElement;
elems(12).Name = 'alpha';
elems(12).Dimensions = [1,nLink];
elems(12).DimensionsMode = 'Fixed';
elems(12).DataType = 'double';
elems(12).SampleTime = -1;
elems(12).Complexity = 'real';

GeometryBus = Simulink.Bus;
GeometryBus.Elements = elems;

%% Mass Properties Bus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'mt';
elems(1).Dimensions = [1];
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real'; 

elems(2) = Simulink.BusElement;
elems(2).Name = 'massVec';
elems(2).Dimensions = [1,nLink+1];
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real';

elems(3) = Simulink.BusElement;
elems(3).Name = 'inertiaMatBase';
elems(3).Dimensions = [3,3];
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).SampleTime = -1;
elems(3).Complexity = 'real';

elems(4) = Simulink.BusElement;
elems(4).Name = 'inertiaMat';
elems(4).Dimensions = [nLink,3,3];
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).SampleTime = -1;
elems(4).Complexity = 'real';

elems(5) = Simulink.BusElement;
elems(5).Name = 'linkInertia';
elems(5).Dimensions = [nLink,3,3];
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'double';
elems(5).SampleTime = -1;
elems(5).Complexity = 'real';

MassPropertiesBus = Simulink.Bus;
MassPropertiesBus.Elements = elems;

%% Rotational State Bus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'quat';
elems(1).Dimensions = [4];
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real'; 


elems(2) = Simulink.BusElement;
elems(2).Name = 'mrp';
elems(2).Dimensions = [3];
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real'; 

elems(3) = Simulink.BusElement;
elems(3).Name = 'euler';
elems(3).Dimensions = [3];
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).SampleTime = -1;
elems(3).Complexity = 'real'; 

elems(4) = Simulink.BusElement;
elems(4).Name = 'angular_rate';
elems(4).Dimensions = [3];
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).SampleTime = -1;
elems(4).Complexity = 'real';

elems(5) = Simulink.BusElement;
elems(5).Name = 'angular_accel';
elems(5).Dimensions = [3];
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'double';
elems(5).SampleTime = -1;
elems(5).Complexity = 'real';

RotStateBus = Simulink.Bus;
RotStateBus.Elements = elems;

%% Translational State Bus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'position';
elems(1).Dimensions = [3];
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real'; 

elems(2) = Simulink.BusElement;
elems(2).Name = 'velocity';
elems(2).Dimensions = [3];
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real'; 

elems(3) = Simulink.BusElement;
elems(3).Name = 'accel';
elems(3).Dimensions = [3];
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).SampleTime = -1;
elems(3).Complexity = 'real';

TransStateBus = Simulink.Bus;
TransStateBus.Elements = elems;


%% State Bus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'rotation';
elems(1).Dimensions = [1];
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'RotStateBus';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real'; 

elems(2) = Simulink.BusElement;
elems(2).Name = 'translation';
elems(2).Dimensions = [1];
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'TransStateBus';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real'; 

elems(3) = Simulink.BusElement;
elems(3).Name = 'poseMatrix';
elems(3).Dimensions = [4,4];
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).SampleTime = -1;
elems(3).Complexity = 'real';

StateBus = Simulink.Bus;
StateBus.Elements = elems;

%% Joint State Bus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'position';
elems(1).Dimensions = [1];
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).SampleTime = -1;
elems(1).Complexity = 'real'; 

elems(2) = Simulink.BusElement;
elems(2).Name = 'velocity';
elems(2).Dimensions = [1];
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).SampleTime = -1;
elems(2).Complexity = 'real'; 

elems(3) = Simulink.BusElement;
elems(3).Name = 'acceleration';
elems(3).Dimensions = [1];
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).SampleTime = -1;
elems(3).Complexity = 'real';

elems(4) = Simulink.BusElement;
elems(4).Name = 'total_torque';
elems(4).Dimensions = [1];
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).SampleTime = -1;
elems(4).Complexity = 'real';

JointStateBus = Simulink.Bus;
JointStateBus.Elements = elems;