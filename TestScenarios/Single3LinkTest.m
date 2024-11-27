
    
dtr = pi/180;

Base_z = 90*dtr;   % Rotation becase Y axis is the joint axis
Base_z = 0;
arm(1).DHparams(1,:) = [sat.service.radius sat.service.length/2 0.0*dtr Base_z];


% Starting end effector state (world) (-0.2711   -1.4456    0.2310) (90 0, -60)
% Desired end effector state (world) (-0.3696   -0.7510    0.2310) 
desired_ee_world_pos = [-0.3696   -0.7510    0.2310];
desired_ee_world_ori = [90.0     0.0000     75]*pi/180;

% Yields desired end effector state  
% arm(1).smiData.RevoluteJoint(1).Rz.Pos = 40.0;
% arm(1).smiData.RevoluteJoint(2).Rz.Pos = -45.0;
% arm(1).smiData.RevoluteJoint(3).Rz.Pos = -30.0;


% Unused for this case
tVec=0:stepSize:endTime;
zeroVec=zeros(1,length(tVec));

angles=[zeroVec; zeroVec; zeroVec];
rates=[zeroVec; zeroVec; zeroVec];

prescribed_jointAngles = timeseries(angles,tVec);
prescribed_jointRates = timeseries(rates,tVec);

clear tVec zeroVec angles rates