
dtr = pi/180;

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

 ss_Jacobian = [ 0.3509   -0.0000    0.3966    0.0000   -0.0572    0.0000         0; ...
                -0.0350   -2.3457   -0.3099    1.2259   -0.1461    0.1700         0; ...
                 0.0000    0.3509   -0.0060   -0.3728    0.0517    0.0006         0; ...
                 0.0000    1.0000   -0.0000   -1.0000   -0.0000   -1.0000   -0.0000; ...
                -0.0000   -0.0000    0.0195    0.0000   -0.3333    0.0000    0.0033; ...
                -1.0000   -0.0000   -0.9998   -0.0000   -0.9428    0.0000   -1.0000];

 ss_MassMatrix = [ 3.8823   -6.1624    1.8857    0.8791    0.0373   -0.0288    0.0490; ...
                  -6.1624  106.9087   10.6475  -41.9774    2.8238   -1.9672   -0.0000; ...
                   1.8857   10.6475    3.6928   -4.4149    0.3448   -0.2546    0.0490; ...
                   0.8791  -41.9774   -4.4149   20.4426   -1.5164    1.0472    0.0000; ...
                   0.0373    2.8238    0.3448   -1.5164    0.3068   -0.1199    0.0462; ...
                  -0.0288   -1.9672   -0.2546    1.0472   -0.1199    0.1808    0.0000; ...
                   0.0490   -0.0000    0.0490    0.0000    0.0462    0.0000    0.0490];
Base_dia = 0.45;
Base_height = 0.09;

% Attach point details for the simscape model
%armAttachOffset(1).orientation = [-90 0 22.5]*dtr;
arm(1).armAttachOffset(1).orientation = [45 0 90]*dtr;
arm(1).armAttachOffset(1).translation = [ 1*(sat.service.radius*cos(pi/8)*(1-cos(pi/4))) -Base_dia/2 sat.service.radius*cos(pi/8)*cos(pi/4)];

arm(2).armAttachOffset(1).orientation = [-45 0 90]*dtr;
arm(2).armAttachOffset(1).translation = [-1*(sat.service.radius*cos(pi/8)*(1-cos(pi/4))) -Base_dia/2 sat.service.radius*cos(pi/8)*cos(pi/4)];

jointControlData.torqueLimit = 100.0*ones(1,nLink);
jointControlData.deadzone = 0.01*ones(1,nLink);

jointControlData.refTime = [0 5 30 50 70];
%jointControlData.eeRefTraj(1,:) = [2.2682    0.5576    2.3177  -90.0*dtr 180.0*dtr -45.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];  % 
%jointControlData.eeRefTraj(2,:) = [2.2682    0.5576    2.3177  -90.0*dtr 180.0*dtr -45.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];  % 
% jointControlData.eeRefTraj(1,:) = [2.3176    0.4924    2.2682     90.0*dtr 45.0*dtr   0.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];  % 
% jointControlData.eeRefTraj(2,:) = [2.3176    0.4924    2.2682    135.0*dtr 45.0*dtr    0.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];  % 

jointControlData.eeRefTraj(1,:) = [2.2724    0.8761    2.2229     90.0*dtr 45.0*dtr   0.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];  %  Joint 4 20 deg, Joint 6 -20 deg
jointControlData.eeRefTraj(2,:) = [2.2724    0.8761    2.2229    135.0*dtr 45.0*dtr    0.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];  % 

% Arm at top of sat
jointControlData.eeRefTraj(1,:) = [0.0350    0.8761    3.1786     90.0*dtr   0.0*dtr   0.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];  %  Joint 4 20 deg, Joint 6 -20 deg
jointControlData.eeRefTraj(2,:) = [0.0350    0.8761    3.1786      0.0*dtr   0.0*dtr    0.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];  % 

jointControlData.eeRefTraj(3,:) = [2.2682    0.5576    2.3177   90.0*dtr 180.0*dtr -45.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(4,:) = [2.2682    0.5576    2.3177  180.0*dtr 0.0*dtr 180.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];
jointControlData.eeRefTraj(5,:) = [2.2682    0.5576    2.3177  180.0*dtr 0.0*dtr 180.0*dtr 0.0 0.0 0.0 0.0 0.0 0.0];