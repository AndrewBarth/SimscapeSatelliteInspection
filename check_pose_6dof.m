    clear DHparams PoseMats
    addpath('Utilities');
    dtr = pi/180;
    nLink=6;

    sat.service.radius = 0.25;
    sat.service.length = 0.5;
    Base_z = 90*dtr;

    %Initialize the RevoluteJoint structure array by filling in null values.
    smiData.RevoluteJoint(6).Rz.Pos = 0.0;
    smiData.RevoluteJoint(6).ID = '';
    
    smiData.RevoluteJoint(1).Rz.Pos = 0.0;  % deg
    smiData.RevoluteJoint(1).ID = '[ArmBase-1:-:ArmSegmentAssembly-2:ArmSegment-1]';
    
    smiData.RevoluteJoint(2).Rz.Pos = 0.0;  % deg
    smiData.RevoluteJoint(2).ID = '[ArmSegmentAssembly-2:ArmSegment-1:-:ArmSegmentAssembly-3:ArmSegment-1]';
    
    smiData.RevoluteJoint(3).Rz.Pos = 0.0;  % deg
    smiData.RevoluteJoint(3).ID = '[ArmSegmentAssembly-3:ArmSegment-1:-:Gripper-2]';
    
    smiData.RevoluteJoint(4).Rz.Pos = 0.0;
    smiData.RevoluteJoint(4).ID = '';
    
    smiData.RevoluteJoint(5).Rz.Pos = 0.0;
    smiData.RevoluteJoint(5).ID = '';
    
    smiData.RevoluteJoint(6).Rz.Pos = 0.0;
    smiData.RevoluteJoint(6).ID = '';

    % Initial Joint Angles and Rates
    for i = 1:nLink
        q(i) = smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end

    ArmBase_height = 0.1;
    ArmLink1_height = 0.1;
    Link_Length(1) = ArmLink1_height;
    Link_Length(2) = 227.5 / 1000;
    Link_Length(3) = 227.5 / 1000;
    Link_Length(4) = 227.5 / 1000;
    Link_Length(5) = 227.5 / 1000;
    Link_Length(6) = 0.065;

    DHparams(1,:) = [sat.service.radius*cos(pi/8)+ArmBase_height sat.service.length/2 0.0*dtr Base_z];
    %DHparams(1,:) = [0.0 0.0 0.0*dtr 0.0*dtr];
    DHparams(2,:) = [Link_Length(1) 0.0  90.0*dtr q(1)];
    DHparams(3,:) = [0.0 Link_Length(2)   0.0     q(2)];
    DHparams(4,:) = [0.0 Link_Length(3)   0.0     q(3)];
    DHparams(5,:) = [0.0 Link_Length(4) 90.0*dtr q(4)];
    DHparams(6,:) = [0 0.0  90*dtr   q(5)+90*dtr];
    %DHparams(6,:) = [0.0 Link_Length(5)  90*dtr   q(5)+90*dtr];
    %DHparams(6,:) = [0.0 Link_Length(5)  90*dtr   q(5)+90*dtr];
    DHparams(7,:) = [Link_Length(6)+Link_Length(5) 0.0225 -90*dtr   q(6)];

%     DHparams(1,:) = [0.8 0.0  90*dtr  0];
%     DHparams(2,:) = [0.0 7.0   0*dtr -1.6370*dtr];
%     DHparams(3,:) = [0.0 6.5   0*dtr  3.4005*dtr];
%     DHparams(4,:) = [0.0 0.4 -90*dtr -1.7630*dtr];
%     DHparams(5,:) = [0.0 0.0  90*dtr 90.0000*dtr];
%     DHparams(6,:) = [1.0 0.0   0*dtr  0*dtr];

%     DHparams(1,:) = [0.8 0.0  90*dtr  30*dtr];
%     DHparams(2,:) = [0.0 7.0   0*dtr 45*dtr];
%     DHparams(3,:) = [0.0 6.5   0*dtr  -10*dtr];
%     DHparams(4,:) = [0.0 0.4 -90*dtr 100*dtr];
%     DHparams(5,:) = [0.0 0.0  90*dtr 20*dtr];
%     DHparams(6,:) = [1.0 0.0   0*dtr -35*dtr];

    % Call forward kinematics to compute pose matrices (relative to spacecraft)
    PoseMats = fKinematics(DHparams,'all');

