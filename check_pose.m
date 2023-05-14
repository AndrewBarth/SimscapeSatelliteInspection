
    clear DHparams PoseMats
    addpath('Utilities');
    dtr = pi/180;
    nLink=5;

    sat.service.radius = 0.25;
    sat.service.length = 0.5;
    Base_z = 90*dtr;

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

    % Initial Joint Angles and Rates
    for i = 1:nLink
        q(i) = smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end

%     Base_height = 79.00 / 1000;
%     %Link_Length(1) = 126.75 / 1000;
%     %Link_Length(2) = 300.00 / 1000;
%     Link_Length(1) = 126.75 / 1000 - Base_height;
%     Link_Length(2) = 300.00 / 1000;
%     Link_Length(3) = 300.00 / 1000;
%     Link_Length(4) = 70.0 / 1000;
%     Link_Length(5) = 65.95 / 1000;
% 
%     waist_offset = [0, 0, 0.079];
%     shoulder_offset = [0, 0, 0.04805];
%     elbow_offset = [0.05955, 0, 0.3];
%     wrist_rotate_offset = [0.069744, 0, 0];
%     gripper_link_offset = [0.042825, 0, 0];
%     gripper_origin_offset = [0.005675, 0, 0];
%     gripper_bar_offset = [0.025875, 0, 0];
%     ee_gripper_origin_offset = [0.0385, 0, 0];
%     ee_offset = wrist_rotate_offset + gripper_link_offset + gripper_origin_offset + gripper_bar_offset + ee_gripper_origin_offset;
% 
%     DHparams(1,:) = [sat.service.radius*cos(pi/8)+Base_height sat.service.length/2 0.0*dtr Base_z];
%     DHparams(2,:) = [Link_Length(1) 0.0 -90.0*dtr q(1)];
%     DHparams(3,:) = [Link_Length(2) elbow_offset(1)  0 q(2)];
%     DHparams(4,:) = [0.0 Link_Length(3) 90.0*dtr q(3)+90*dtr];
%     DHparams(5,:) = [Link_Length(4) 0.0 0.0*dtr q(4)];
%     DHparams(6,:) = [0.0 Link_Length(5) 0*dtr q(5)];

%     DHparams(1,:) = [sat.service.radius*cos(pi/8)+Base_height sat.service.length/2 0.0*dtr Base_z];
%     DHparams(2,:) = [Link_Length(1) 0.0  90.0*dtr q(1)];
%     DHparams(3,:) = [0.0 Link_Length(2)   0.0*dtr q(2)+90*dtr];
%     DHparams(4,:) = [0.0 Link_Length(3)+elbow_offset(1)  90.0*dtr q(3)-90*dtr];
%     DHparams(5,:) = [0.0 0.0             90.0*dtr q(4)+90*dtr];
%     DHparams(6,:) = [ee_offset(1) 0.0   0.0*dtr q(5)];


    Base_height = 79.00 / 1000;
    waist_offset = [0, 0, 0.079];
    shoulder_offset = [0, 0, 0.04805];
    elbow_offset = [0.05955, 0, 0.3];
    wrist_rotate_offset = [0.069744, 0, 0];
    gripper_link_offset = [0.042825, 0, 0];
    gripper_origin_offset = [0.005675, 0, 0];
    gripper_bar_offset = [0.025875, 0, 0];
    ee_gripper_origin_offset = [0.0385, 0, 0];
    ee_offset = wrist_rotate_offset + gripper_link_offset + ...
                gripper_origin_offset + gripper_bar_offset + ee_gripper_origin_offset;
    Link_Length(1) = 126.75 / 1000 - Base_height;
    Link_Length(2) = 300.00 / 1000;
    Link_Length(3) = 300.00 / 1000 + elbow_offset(1);
    Link_Length(4) = 0.0 / 1000;
    Link_Length(5) = ee_offset(1);

    DHparams(1,:) = [sat.service.radius*cos(pi/8)+Base_height sat.service.length/2 0.0*dtr Base_z];
    DHparams(2,:) = [Link_Length(1) 0.0  90.0*dtr q(1)];
    DHparams(3,:) = [0.0 Link_Length(2)   0.0*dtr q(2)+90*dtr];
    DHparams(4,:) = [0.0 Link_Length(3)  90.0*dtr q(3)-90*dtr];
    DHparams(5,:) = [0.0 Link_Length(4)  90.0*dtr q(4)+90*dtr];
    DHparams(6,:) = [Link_Length(5) 0.0   0.0*dtr q(5)];

    % Call forward kinematics to compute pose matrices (relative to spacecraft)
    PoseMats = fKinematics(DHparams,'all');

%     for i=1:nLink+1
%         fprintf('Joint %d',i-1)
%         squeeze(PoseMats(:,:,i))
%     end
