% Define default parameters for a general 6DOF arm

NLINKS.Value = 6;
arm(1).nLink = 6;
arm(2).nLink = 0;

% Arbitary values (in m)
arm(1).Link_Length(1) = 227.5 / 1000;
arm(1).Link_Length(2) = 227.5 / 1000;
arm(1).Link_Length(3) = 227.5 / 1000;
arm(1).Link_Length(4) = 227.5 / 1000;
arm(1).Link_Length(5) = 227.5 / 1000;
arm(1).Link_Length(6) = 0.065;

arm(1).Link_CG(1,:) = [arm(1).Link_Length(1)/2 0 0];
arm(1).Link_CG(2,:) = [arm(1).Link_Length(2)/2 0 0];
arm(1).Link_CG(3,:) = [arm(1).Link_Length(3)/2 0 0];
arm(1).Link_CG(4,:) = [arm(1).Link_Length(4)/2 0 0];
arm(1).Link_CG(5,:) = [arm(1).Link_Length(5)/2 0 0];
arm(1).Link_CG(6,:) = [arm(1).Link_Length(6)/2 0 0];


arm(1).Joint_Limits(1,:) = [-2*pi 2*pi];
arm(1).Joint_Limits(2,:) = [-2*pi 2*pi];
arm(1).Joint_Limits(3,:) = [-2*pi 2*pi];
arm(1).Joint_Limits(4,:) = [-2*pi 2*pi];
arm(1).Joint_Limits(5,:) = [-2*pi 2*pi];
arm(1).Joint_Limits(6,:) = [-2*pi 2*pi];