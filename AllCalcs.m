%% Rod Calculations
rod.rho = material.rho;  % Density (kg/m3)
rod.E   = material.E;    % Young's Modulous (GPa)
rod.G   = material.G;    % Shear Modulous (GPa)

%% Satellite Calculations
% None were needed for this method

%% Joint Control Calculations
% Set up mass properties
m_base = sat.service.mass + smiData.Solid(1).mass;  % Sum satellite base and arm base
for i = 1:nLink
    m_link(i) = smiData.Solid(i+1).mass;
end
mt = m_base + sum(m_link);
massVec = [m_base m_link];

% NEED TO ADD IN INERTIA OF ARM BASE (also check order of PoI variables)
inertiaMatBase = [sat.service.MoI(1) sat.service.PoI(1) sat.service.PoI(2); ... 
                  sat.service.PoI(1) sat.service.MoI(2) sat.service.PoI(3); ...
                  sat.service.PoI(2) sat.service.PoI(3) sat.service.MoI(3)];
              
linkIdx = 1;
for i = 1:nLink
    inertiaMat(i,:,:) = [smiData.Solid(i+linkIdx).MoI(1) smiData.Solid(i+linkIdx).PoI(1) smiData.Solid(i+linkIdx).PoI(2); ... 
                         smiData.Solid(i+linkIdx).PoI(1) smiData.Solid(i+linkIdx).MoI(2) smiData.Solid(i+linkIdx).PoI(3); ...
                         smiData.Solid(i+linkIdx).PoI(2) smiData.Solid(i+linkIdx).PoI(3) smiData.Solid(i+linkIdx).MoI(3)]/1000/1000; % Convert from kg*mm2 to kg*m2
end
linkInertia = zeros(nLink,3,3);
massProperties(1).mt = mt;
massProperties(1).massVec = massVec;
massProperties(1).inertiaMatBase = inertiaMatBase;
massProperties(1).inertiaMat = inertiaMat;
massProperties(1).linkInertia = linkInertia;

if ARM_TYPE == 1
    DHparams(1,:) = [sat.service.radius sat.service.length/2 0.0*dtr Base_z];
    DHparams(2,:) = [0.0 Link_Length(1) 0.0 q(1)];
    DHparams(3,:) = [Link_Length(2) 0.0 90*dtr q(2)];
    DHparams(4,:) = [0.0 Link_Length(3) 0.0 q(3)];
    DHparams(5,:) = [0.0 Link_Length(4) 0.0 q(4)];
    DHparams(6,:) = [Link_Length(5) 0.0  90*dtr q(5)];
elseif ARM_TYPE == 2
    DHparams(1,:) = [sat.service.radius sat.service.length/2 0.0*dtr Base_z];
    DHparams(2,:) = [0.0 Link_Length(1) 0.0 q(1)];
    DHparams(3,:) = [Link_Length(2) 0.0 90*dtr q(2)];
    DHparams(4,:) = [0.0 Link_Length(3) 0.0 q(3)];
    DHparams(5,:) = [0.0 Link_Length(4) 0.0 q(4)];
    DHparams(6,:) = [Link_Length(5) 0.0  90*dtr q(5)];
    DHparams(7,:) = [Link_Length(6) 0.0  90*dtr q(6)];
else
    DHparams(1,:) = [sat.service.radius sat.service.length/2 0.0*dtr Base_z];
    for i = 1:nLink
        DHparams(i+1,:) = [0.0 Link_Length(i) 0.0 q(i)];
    end
end

% Call forward kinematics to compute pose matrices (relative to spacecraft)
PoseMats = fKinematics(DHparams,'all');

Base_a = sat.service.radius; % This should be the base of the arm
Base_b = sat.service.radius;
Base_c = sat.service.length;

% Initial State
rBase0  = [sat.service.IC.pose.position.x sat.service.IC.pose.position.y sat.service.IC.pose.position.z];
xcmDot = sat.service.IC.twist.linear.x;
ycmDot = sat.service.IC.twist.linear.y;
zcmDot = sat.service.IC.twist.linear.z;
phi   = sat.service.IC.pose.orientation(3);
theta = sat.service.IC.pose.orientation(1);
psi   = sat.service.IC.pose.orientation(2);
w_x   = sat.service.IC.twist.angular(1);
w_y   = sat.service.IC.twist.angular(2);
w_z   = sat.service.IC.twist.angular(3);


% Compute initial geometry
%Rot_Inertial_To_SC = robotZRot(psi)*robotYRot(theta)*robotXRot(phi);
% Rot_Inertial_To_SC = robotXRot(phi)*robotZRot(psi)*robotYRot(theta);
% Tmat(1,:,:) = [ [Rot_Inertial_To_SC(1:3,1:3) [0 0 0]']; [0 0 0 1] ];
% T10 = [PoseMats(1:3,1:3,1) PoseMats(1:3,4,1); [0 0 0 1] ];
% T20 = [PoseMats(1:3,1:3,2) PoseMats(1:3,4,2); [0 0 0 1] ];
% T30 = [PoseMats(1:3,1:3,3) PoseMats(1:3,4,3); [0 0 0 1] ];
% T40 = [PoseMats(1:3,1:3,4) PoseMats(1:3,4,4); [0 0 0 1] ];
% 
% rBase = rBase0';

busInfo = Simulink.Bus.createObject(jointControlData);
jointControlDataBus = evalin('base',busInfo.busName);
%% Satellite Control Calculations
% This is a relative position and velocity to the client
satControlData.Trans.cmdPos = IC.rel_position;

% Create Simulink Bus
busInfo = Simulink.Bus.createObject(satControlData);
satControlDataBus = evalin('base',busInfo.busName);
