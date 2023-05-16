    clear DHparams PoseMats
    addpath('Utilities');
    dtr = pi/180;
    nLink=7;

% Mass Properties of servicing satellite
sat.service.mass = 450;
sat.service.radius = 0.75;
sat.service.length = 1.5;
% The following mass properties are derived from simscape
sat.service.Com = [0 0 0];
sat.service.MoI = [5.23993, 5.23993, 4.22985];
sat.service.PoI = [0 0 0];

% Solar panel masses are ignored by controller
sat.service.panel.mass = 0.75;
sat.service.panel.dim = [1.5 0.015 0.9];
sat.service.panel_mount.mass = 0.5;
sat.service.panel_mount.dim = [0.15 0.03 0.03];


Base_dia = 0.45;
Base_height = 0.09;
%armAttachOffset(1).orientation = [-90 0 22.5]*dtr;
armAttachOffset(1).orientation = [-45 0 90]*dtr;
armAttachOffset(1).translation = [sat.service.radius*cos(pi/8)*sin(pi/4) -Base_dia/2 -1*(1-cos(pi/4))+Base_height];
    Base_z = 90*dtr;


%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(7).Rz.Pos = 0.0;
smiData.RevoluteJoint(7).ID = "";

smiData.RevoluteJoint(1).Rz.Pos = 90.0;  % deg
smiData.RevoluteJoint(1).ID = "[Shoulder-1:Joint-1]";

smiData.RevoluteJoint(2).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(2).ID = "[Shoulder-2:Joint-2]";

smiData.RevoluteJoint(3).Rz.Pos = 0;  % deg
smiData.RevoluteJoint(3).ID = "[Shoulder-3:Joint-3]";

% smiData.RevoluteJoint(4).Rz.Pos = -95.03088396129948;  % deg
smiData.RevoluteJoint(4).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(4).ID = "[Elbow-1:Joint-4]";

smiData.RevoluteJoint(5).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(5).ID = "[Elbow-2:Joint-5]";

% smiData.RevoluteJoint(6).Rz.Pos = 0.0;  % deg
smiData.RevoluteJoint(6).Rz.Pos = -90.0;  % deg
smiData.RevoluteJoint(6).ID = "[Wrist-1:Joint-6]";

% smiData.RevoluteJoint(7).Rz.Pos = 90.0;  % deg
smiData.RevoluteJoint(7).Rz.Pos = -45.0;  % deg
smiData.RevoluteJoint(7).ID = "[Wrist-2:Joint-7]";

    % Initial Joint Angles and Rates
    for i = 1:nLink
        q(i) = smiData.RevoluteJoint(i).Rz.Pos*dtr;
        qDot(i) = 0.0;
    end

    Base_height = 0.04;
    Base_dia = 0.45;
    % CAD model values (in m)
    Link_Length(1) = 0.1; 
    Link_Length(1) = 0.05 + 0.04 + 0.1;
    Link_Length(2) = 0.35 - .15 + 0.075;   % subtract half of shoulder_2 and add radius of shoulder 3
    Link_Length(3) = 0.20 / 2 + 1;     % half the length of shoulder 3 plus main link 1
    Link_Length(4) = 0.075 + 0.075;    % half elbow 1 plus radius elbow 2
    Link_Length(5) = 0.2 - 0.06 + 1;   % subtract elbow joint 1 radius plus main link 2
    Link_Length(6) = 0.075 + 0.075;    % half wrist 1 plus radius wrist 2
    Link_Length(7) = 0.2 - 0.06;       % subtract wrist joint 1 radius

%     attachPnt = [sat.service.radius*cos(pi/8)*cos(pi/4) + 0.04*cos(pi/4)
%                  sat.service.length/2-Base_dia/2
%                  sat.service.radius*cos(pi/8)*sin(pi/4) + 0.04*sin(pi/4)];


    attachPnt = [sat.service.radius*cos(pi/8)*cos(pi/4)
                 sat.service.length/2-Base_dia/2
                 sat.service.radius*cos(pi/8)*sin(pi/4)];

    thetaOffset = [0 0 0 0 0 0 -90]*dtr;
    DHparams(1,:) = [ Link_Length(1) 0.0              90.0*dtr q(1)+thetaOffset(1)];
    DHparams(2,:) = [ Link_Length(2) 0.0             -90.0*dtr q(2)+thetaOffset(2)];
    DHparams(3,:) = [ Link_Length(3) 0.0              90.0*dtr q(3)+thetaOffset(3)];
    DHparams(4,:) = [-Link_Length(4) 0.0             -90.0*dtr q(4)+thetaOffset(4)];
    DHparams(5,:) = [ Link_Length(5) 0.0              90.0*dtr q(5)+thetaOffset(5)];
    DHparams(6,:) = [-Link_Length(6) 0.0             -90.0*dtr q(6)+thetaOffset(6)];
    DHparams(7,:) = [ Link_Length(7) 0.0              90.0*dtr q(7)+thetaOffset(7)];

    % Call forward kinematics to compute pose matrices (relative to spacecraft)

    temp = zeros(4,4,nLink+1);
    temp = fKinematics(DHparams,'all');
    angles = [0 -45 0]*pi/180;
    mat = EulerToDCM_321(angles); 
%     mat = robotEulerToDCM_321(angles);
    %PoseMats(:,:,1) = [ [mat [attachPnt+mat*temp(1:3,4,1)]]; [0 0 0 1] ];
    PoseMats(:,:,1) = [ [mat [attachPnt]]; [0 0 0 1] ];
%     for i=2:nLink+1    
%         PoseMats(:,:,i) = PoseMats(:,:,1)*temp(:,:,i);
%     end
    for i=1:nLink    
        PoseMats(:,:,i+1) = PoseMats(:,:,1)*temp(:,:,i);
    end
