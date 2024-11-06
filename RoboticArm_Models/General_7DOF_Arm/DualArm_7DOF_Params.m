% Define default parameters for two 7-DOF arms

NLINKS.Value = 7;

arm(1).nLink = 7;

Base_height = 0.04;
Base_dia = 0.45;
% CAD model values (in m)
arm(1).Link_Length(1) = 0.05 + 0.04 + 0.1;   % Attach base plus Base height plus shoulder 1
arm(1).Link_Length(2) = 0.35 - .15 + 0.075;   % subtract half of shoulder_2 and add radius of shoulder 3
%     arm(1).Link_Length(3) = 0.20 / 2 + 1;     % half the length of shoulder 3 plus main link 1
arm(1).Link_Length(3) = (0.20 - .16/2) + 1;   % shoulder 3 minus radius of shoulder 2 plus main link 1
%     arm(1).Link_Length(4) = 0.075 + 0.075;    % half elbow 1 plus radius elbow 2
arm(1).Link_Length(4) =  0.15 - 0.15/2 + 0.15/2; % subtract radius of main link 1 and add radius of elbow 2
%     arm(1).Link_Length(5) = 0.2 - 0.06 + 1;   % subtract elbow joint 1 radius plus main link 2
arm(1).Link_Length(5) = (0.20 - .12/2) + 1;   % elbow 2 minus radius of elbow 1 pluse main link 2
%     arm(1).Link_Length(6) = 0.075 + 0.075;    % half wrist 1 plus radius wrist 2
arm(1).Link_Length(6) = 0.15 - 0.15/2 + 0.15/2; % subtract radius of main link 2 and add radius of wrist 2
%     arm(2).Link_Length(6) = 0.2 - 0.12/2;     % subtract radius of elbow 1
arm(1).Link_Length(7) = 0.2 - 0.06;       % subtract wrist joint 1 radius

% % Arbitary values (in m)
% arm(1).Link_Length(1) = ArmLink1_height;
% arm(1).Link_Length(2) = 227.5 / 1000;
% arm(1).Link_Length(3) = 227.5 / 1000;
% arm(1).Link_Length(4) = 227.5 / 1000;
% arm(1).Link_Length(5) = 227.5 / 1000;
% arm(1).Link_Length(6) = 0.065;

arm(1).Link_CG(1,:) = [0 0  arm(1).Link_Length(1)/2];
arm(1).Link_CG(2,:) = [0 0  arm(1).Link_Length(2)/2];
arm(1).Link_CG(3,:) = [0 0  arm(1).Link_Length(3)/2];
arm(1).Link_CG(4,:) = [0 0 -arm(1).Link_Length(4)/2];
arm(1).Link_CG(5,:) = [0 0  arm(1).Link_Length(5)/2];
arm(1).Link_CG(6,:) = [0 0 -arm(1).Link_Length(6)/2];
arm(1).Link_CG(7,:) = [0 0  arm(1).Link_Length(7)/2];

arm(1).Joint_Limits(1,:) = [-2*pi 2*pi];
arm(1).Joint_Limits(2,:) = [-2*pi 2*pi];
arm(1).Joint_Limits(3,:) = [-2*pi 2*pi];
arm(1).Joint_Limits(4,:) = [-2*pi 2*pi];
arm(1).Joint_Limits(5,:) = [-2*pi 2*pi];
arm(1).Joint_Limits(6,:) = [-2*pi 2*pi];
arm(1).Joint_Limits(7,:) = [-2*pi 2*pi];

% Arm 2
arm(2).nLink = 7;
Base_height = 0.04;
Base_dia = 0.45;
% CAD model values (in m)
arm(2).Link_Length(1) = 0.05 + 0.04 + 0.1;   % Attach base plus Base height plus shoulder 1
arm(2).Link_Length(2) = 0.35 - .15 + 0.075;   % subtract half of shoulder_2 and add radius of shoulder 3
%     arm(2).Link_Length(3) = 0.20 / 2 + 1;     % half the length of shoulder 3 plus main link 1
arm(2).Link_Length(3) = (0.20 - .16/2) + 1;   % shoulder 3 minus radius of shoulder 2 plus main link 1
%     arm(2).Link_Length(4) = 0.075 + 0.075;    % half elbow 1 plus radius elbow 2
arm(2).Link_Length(4) =  0.15 - 0.15/2 + 0.15/2; % subtract radius of main link 1 and add radius of elbow 2
%     arm(2).Link_Length(5) = 0.2 - 0.06 + 1;   % subtract elbow joint 1 radius plus main link 2
arm(2).Link_Length(5) = (0.20 - .12/2) + 1;   % elbow 2 minus radius of elbow 1 pluse main link 2
%     arm(2).Link_Length(6) = 0.075 + 0.075;    % half wrist 1 plus radius wrist 2
arm(2).Link_Length(6) = 0.15 - 0.15/2 + 0.15/2; % subtract radius of main link 2 and add radius of wrist 2
%     arm(2).Link_Length(6) = 0.2 - 0.12/2;     % subtract radius of elbow 1
arm(2).Link_Length(7) = 0.2 - 0.06;       % subtract wrist joint 1 radius


arm(2).Link_CG(1,:) = [0 0  arm(2).Link_Length(1)/2];
arm(2).Link_CG(2,:) = [0 0  arm(2).Link_Length(2)/2];
arm(2).Link_CG(3,:) = [0 0  arm(2).Link_Length(3)/2];
arm(2).Link_CG(4,:) = [0 0 -arm(2).Link_Length(4)/2];
arm(2).Link_CG(5,:) = [0 0  arm(2).Link_Length(5)/2];
arm(2).Link_CG(6,:) = [0 0 -arm(2).Link_Length(6)/2];
arm(2).Link_CG(7,:) = [0 0  arm(2).Link_Length(7)/2];

arm(2).Joint_Limits(1,:) = [-2*pi 2*pi];
arm(2).Joint_Limits(2,:) = [-2*pi 2*pi];
arm(2).Joint_Limits(3,:) = [-2*pi 2*pi];
arm(2).Joint_Limits(4,:) = [-2*pi 2*pi];
arm(2).Joint_Limits(5,:) = [-2*pi 2*pi];
arm(2).Joint_Limits(6,:) = [-2*pi 2*pi];
arm(2).Joint_Limits(7,:) = [-2*pi 2*pi];