% Define default parameters for two 3-DOF planar arms

NLINKS.Value = 3;
arm(1).nLink = 3;

% Data from Solidworks model (in m)
% arm(1).Link_Length(1) = 0.2;
% arm(1).Link_Length(2) = 0.2;
% arm(1).Link_Length(3) = 0.08;
arm(1).Link_Length(1) = 0.22;
arm(1).Link_Length(2) = 0.22;
% arm(1).Link_Length(3) = 0.065;
arm(1).Link_Length(3) = 0.07;

arm(1).Link_CG(1,:) = [arm(1).Link_Length(1)/2 0 0];
arm(1).Link_CG(2,:) = [arm(1).Link_Length(2)/2 0 0];
arm(1).Link_CG(3,:) = [arm(1).Link_Length(3)/2 0 0];

arm(1).Joint_Limits(1,:) = [-120 120]*pi/180;
arm(1).Joint_Limits(2,:) = [-120 120]*pi/180;
arm(1).Joint_Limits(3,:) = [-120 120]*pi/180;


arm(2).nLink = 3;
% Data from Solidworks model (in m)
% arm(2).Link_Length(1) = 0.2;
% arm(2).Link_Length(2) = 0.2;
% arm(2).Link_Length(3) = 0.08;
arm(2).Link_Length(1) = 0.22;
arm(2).Link_Length(2) = 0.22;
% arm(2).Link_Length(3) = 0.065;
arm(2).Link_Length(3) = 0.07;

arm(2).Link_CG(1,:) = [arm(2).Link_Length(1)/2 0 0];
arm(2).Link_CG(2,:) = [arm(2).Link_Length(2)/2 0 0];
arm(2).Link_CG(3,:) = [arm(2).Link_Length(3)/2 0 0];

arm(2).Joint_Limits(1,:) = [-120 120]*pi/180;
arm(2).Joint_Limits(2,:) = [-120 120]*pi/180;
arm(2).Joint_Limits(3,:) = [-120 120]*pi/180;