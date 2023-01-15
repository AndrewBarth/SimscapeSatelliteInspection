%% Rod Calculations
rod.rho = material.rho;  % Density (kg/m3)
rod.E   = material.E;    % Young's Modulous (GPa)
rod.G   = material.G;    % Shear Modulous (GPa)

%% Satellite Calculations
% None were needed for this method

%% Joint Control Calculations


% DH parameters order: [d a alpha theta]
%         d:     distance along z axis
%         a:     distance along x axis
%         alpha: rotation about x axis
%         theta: rotation about z axis
if ARM_TYPE == 1
    armAttachPnt = [0 0 0];
    armAttachAngles = [0 0 0]*dtr;
    thetaOffset = [0 90 -90 90 0]*dtr;
%     DHparams(1,:) = [sat.service.radius sat.service.length/2 0.0*dtr Base_z];
%     DHparams(2,:) = [0.0 Link_Length(1) 0.0 q(1)+thetaOffset(1)];
%     DHparams(3,:) = [Link_Length(2) 0.0 90*dtr q(2)+thetaOffset(2)];
%     DHparams(4,:) = [0.0 Link_Length(3) 0.0 q(3)+thetaOffset(3)];
%     DHparams(5,:) = [0.0 Link_Length(4) 0.0 q(4)+thetaOffset(4)];
%     DHparams(6,:) = [Link_Length(5) 0.0  90*dtr q(5)+thetaOffset(5)];
%     DHparams(1,:) = [sat.service.radius*cos(pi/8)+Base_height sat.service.length/2 0.0*dtr Base_z];
    DHparams(1,:) = [0 sat.service.length/2 0.0*dtr Base_z];
    DHparams(2,:) = [Link_Length(1) 0.0  90.0*dtr q(1)+thetaOffset(1)];
    DHparams(3,:) = [0.0 Link_Length(2)   0.0*dtr q(2)+thetaOffset(2)];
    DHparams(4,:) = [0.0 Link_Length(3)  90.0*dtr q(3)+thetaOffset(3)];
    DHparams(5,:) = [0.0 Link_Length(4)  90.0*dtr q(4)+thetaOffset(4)];
    DHparams(6,:) = [Link_Length(5) 0.0   0.0*dtr q(5)+thetaOffset(5)];
    
    % Set up mass properties
    % THESE ARE PROBABLY INCORRECT. NEED TO MATCH THIS WITH ARM MODEL
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

elseif ARM_TYPE == 2
    armAttachPnt = [0 0 0];
    armAttachAngles = [0 0 0]*dtr;
    thetaOffset = [0 0 0 0 90 0]*dtr;
%     DHparams(1,:) = [sat.service.radius*cos(pi/8)+ArmBase_height sat.service.length/2 0.0*dtr Base_z];
%     DHparams(2,:) = [Link_Length(1) 0.0  90.0*dtr q(1)+thetaOffset(1)];
%     DHparams(3,:) = [0.0 Link_Length(2)   0.0     q(2)];
%     DHparams(4,:) = [0.0 Link_Length(3)   0.0     q(3)];
%     DHparams(5,:) = [0.0 Link_Length(4)  90.0*dtr q(4)];
%     DHparams(6,:) = [Link_Length(5) 0.0  90*dtr   q(5)+90*dtr];
%     DHparams(7,:) = [Link_Length(6) 0.0 -90*dtr   q(6)];

    DHparams(1,:) = [sat.service.radius*cos(pi/8)+ArmBase_height sat.service.length/2 0.0*dtr Base_z];
%     DHparams(2,:) = [Link_Length(1) 0.0  90.0*dtr q(1)];
%     DHparams(3,:) = [0.0 Link_Length(2)   0.0     q(2)];
%     DHparams(4,:) = [0.0 Link_Length(3)   0.0     q(3)];
%     DHparams(5,:) = [0.0 Link_Length(4)  90.0*dtr q(4)];
%     %DHparams(6,:) = [Link_Length(5) 0.0  90*dtr   q(5)+90*dtr];
%     DHparams(6,:) = [0.0 Link_Length(5)  90*dtr   q(5)+90*dtr];
%     %DHparams(6,:) = [0.0 Link_Length(5)  90*dtr   q(5)+0*dtr];
%     DHparams(7,:) = [Link_Length(6) 0.0225 -90*dtr   q(6)];
% 
%     DHparams(6,:) = [Link_Length(5) 0.0  90*dtr   q(5)+90*dtr];
%     %DHparams(6,:) = [0.0 Link_Length(5)  90*dtr   q(5)+90*dtr];
%     %DHparams(6,:) = [0.0 Link_Length(5)  90*dtr   q(5)+90*dtr];
%     DHparams(7,:) = [Link_Length(6) 0.0225 -90*dtr   q(6)];

    DHparams(2,:) = [Link_Length(1) 0.0  90*dtr  q(1)+thetaOffset(1)];
    DHparams(3,:) = [0.0 Link_Length(2)   0*dtr  q(2)+thetaOffset(2)];
    DHparams(4,:) = [0.0 Link_Length(3)   0*dtr  q(3)+thetaOffset(3)];
    DHparams(5,:) = [0.0 Link_Length(4)  90*dtr  q(4)+thetaOffset(4)];
    DHparams(6,:) = [0.0 0.0             90*dtr  q(5)+thetaOffset(5)];
    DHparams(7,:) = [Link_Length(5)+Link_Length(6) 0.0  -90*dtr  q(6)+thetaOffset(6)];

%     DHparams(1,:) = [Link_Length(1) 0.0  90*dtr  q(1)];
%     DHparams(2,:) = [0.0 Link_Length(2)   0*dtr  q(2)];
%     DHparams(3,:) = [0.0 Link_Length(3)   0*dtr  q(3)];
%     DHparams(4,:) = [0.0 Link_Length(4) -90*dtr  q(4)];
%     DHparams(5,:) = [0.0 Link_Length(5)  90*dtr  q(5)+90*dtr];
%     DHparams(6,:) = [Link_Length(6) 0.0   0*dtr  q(6)];
%     DHparams(7,:) = [0.0 0.0   0  0];

%     DHparams(1,:) = [0.8 0.0  90*dtr  0];
%     DHparams(2,:) = [0.0 7.0   0*dtr -1.6370*dtr];
%     DHparams(3,:) = [0.0 6.5   0*dtr  3.4005*dtr];
%     DHparams(4,:) = [0.0 0.4 -90*dtr -1.7630*dtr];
%     DHparams(5,:) = [0.0 0.0  90*dtr 90.0000*dtr];
%     DHparams(6,:) = [1.0 0.0   0*dtr  0*dtr];
%     DHparams(7,:) = [1.0 0.0   0*dtr  0*dtr];

    % Set up mass properties
    % THESE ARE PROBABLY INCORRECT. NEED TO MATCH THIS WITH ARM MODEL
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
elseif ARM_TYPE == 3

%     armAttachPnt = [sat.service.radius*cos(pi/8)*cos(pi/4)
%                     sat.service.length/2-Base_dia/2
%                     sat.service.radius*cos(pi/8)*sin(pi/4)];
%     armAttachAngles = [-45 0 90]*dtr;


    armAttachPnt = [0
                    sat.service.length/2-Base_dia/2
                    sat.service.radius*cos(pi/8)*sin(pi/4)];
    armAttachAngles = [0 0 90]*dtr;


    thetaOffset = [0 0 0 0 0 0 -90]*dtr;
%     DHparams(1,:) = [ Link_Length(1) 0.0              90.0*dtr q(1)+thetaOffset(1)];
%     DHparams(2,:) = [ Link_Length(2) 0.0             -90.0*dtr q(2)+thetaOffset(2)];
%     DHparams(3,:) = [ Link_Length(3) 0.0              90.0*dtr q(3)+thetaOffset(3)];
%     DHparams(4,:) = [-Link_Length(4) 0.0             -90.0*dtr q(4)+thetaOffset(4)];
%     DHparams(5,:) = [ Link_Length(5) 0.0              90.0*dtr q(5)+thetaOffset(5)];
%     DHparams(6,:) = [-Link_Length(6) 0.0             -90.0*dtr q(6)+thetaOffset(6)];
%     DHparams(7,:) = [ Link_Length(7) 0.0              90.0*dtr q(7)+thetaOffset(7)];

    DHparams(1,:) = [0 0 0 0];
    DHparams(2,:) = [ Link_Length(1) 0.0              90.0*dtr q(1)+thetaOffset(1)];
    DHparams(3,:) = [ Link_Length(2) 0.0             -90.0*dtr q(2)+thetaOffset(2)];
    DHparams(4,:) = [ Link_Length(3) 0.0              90.0*dtr q(3)+thetaOffset(3)];
    DHparams(5,:) = [-Link_Length(4) 0.0             -90.0*dtr q(4)+thetaOffset(4)];
    DHparams(6,:) = [ Link_Length(5) 0.0              90.0*dtr q(5)+thetaOffset(5)];
    DHparams(7,:) = [-Link_Length(6) 0.0             -90.0*dtr q(6)+thetaOffset(6)];
    DHparams(8,:) = [ Link_Length(7) 0.0               0.0*dtr q(7)+thetaOffset(7)];
    % Set up mass properties
    % THESE ARE PROBABLY INCORRECT. NEED TO MATCH THIS WITH ARM MODEL
    m_base = sat.service.mass + smiData.Solid(1).mass;  % Sum satellite base and arm base

    baseIdx = [11 9];
%     linkIdx{1} = [7];
%     linkIdx{2} = [8];
%     linkIdx{3} = [10 1];
%     linkIdx{4} = [4];
%     linkIdx{5} = [2 3];
%     linkIdx{6} = [5];
%     linkIdx{7} = [6 12];

%     linkIdx{1} = [7 8];
    linkIdx{1} = [7];
    linkIdx{2} = [10];
%     linkIdx{3} = [1 4];
    linkIdx{3} = [1];
    linkIdx{4} = [2];
%     linkIdx{5} = [3 5];
    linkIdx{5} = [3];
    linkIdx{6} = [6];
    linkIdx{7} = [12];

    inertiaRot(11,:,:) = XRot(-pi/2);
    inertiaRot(9,:,:)  = XRot(-pi/2);
%     inertiaRot(7,:,:)  = XRot(-pi/2);
    inertiaRot(7,:,:)  = XRot(0);
    inertiaRot(8,:,:)  = XRot(0);
    inertiaRot(10,:,:) = XRot(-pi/2);
%     inertiaRot(1,:,:)  = XRot(-pi/2);
    inertiaRot(1,:,:)  = XRot(0);
    inertiaRot(4,:,:)  = XRot(0);
    inertiaRot(2,:,:)  = XRot(-pi/2);
%     inertiaRot(3,:,:)  = XRot(-pi/2);
    inertiaRot(3,:,:)  = XRot(0);
    inertiaRot(5,:,:)  = XRot(0);
    inertiaRot(6,:,:)  = XRot(-pi/2);
    inertiaRot(12,:,:) = XRot(-pi/2);

    m_base = sat.service.mass;
    for j=1:length(baseIdx)
        m_base = m_base + smiData.Solid(baseIdx(j)).mass;
    end
    for i = 1:nLink
        m_link(i) = 0;
        for j=1:length(linkIdx{i})
            m_link(i) = m_link(i) + smiData.Solid(linkIdx{i}(j)).mass;
        end
    end
    mt = m_base + sum(m_link);
    massVec = [m_base m_link];
    
    % NEED TO ADD IN INERTIA OF ARM BASE (also check order of PoI variables)
    inertiaMatBase = [sat.service.MoI(1) sat.service.PoI(1) sat.service.PoI(2); ... 
                      sat.service.PoI(1) sat.service.MoI(2) sat.service.PoI(3); ...
                      sat.service.PoI(2) sat.service.PoI(3) sat.service.MoI(3)];

    for i = 1:nLink
        modelInertia(i,:,:) = zeros(3,3);
        modelInertia(i,:,:) = [smiData.Solid(linkIdx{i}).MoI(1) smiData.Solid(linkIdx{i}).PoI(1) smiData.Solid(linkIdx{i}).PoI(2); ... 
                               smiData.Solid(linkIdx{i}).PoI(1) smiData.Solid(linkIdx{i}).MoI(2) smiData.Solid(linkIdx{i}).PoI(3); ...
                               smiData.Solid(linkIdx{i}).PoI(2) smiData.Solid(linkIdx{i}).PoI(3) smiData.Solid(linkIdx{i}).MoI(3)];
    end
%     modelInertia(1,:,:) = [0.1523 0.005 0;  0.005 0.0709 0; 0 0 0.1301];
    modelInertia(1,:,:) = [0.1301 0 0; 0 0.1523 -0.005; 0 -0.005 0.709];
    modelInertia(3,:,:) = [1.5782 -0.0298 0.0003; -0.0298 0.0446 0.0137; 0.0003 0.0137 1.5691];
    modelInertia(5,:,:) = [1.5552 -0.014 0.0001; -0.014 0.0441 0.0136; 0.0001 0.0136 1.5509];
    for i = 1:nLink
        inertiaMat(i,:,:) = zeros(3,3);
        for j=1:length(linkIdx{i})
            linkI = linkIdx{i}(j);
            % THIS CALC IS NOT ACCURATE. CANNOT JUST ADD INERTIAS LIKE
            % THIS. NEED TO USE PARALLEL AXIS THEOREM
%             inertiaMat(i,:,:) = squeeze(inertiaMat(i,:,:)) + squeeze(inertiaRot(linkI,:,:))'* ...
%                                                          [smiData.Solid(linkI).MoI(1) smiData.Solid(linkI).PoI(1) smiData.Solid(linkI).PoI(2); ... 
%                                                           smiData.Solid(linkI).PoI(1) smiData.Solid(linkI).MoI(2) smiData.Solid(linkI).PoI(3); ...
%                                                           smiData.Solid(linkI).PoI(2) smiData.Solid(linkI).PoI(3) smiData.Solid(linkI).MoI(3)]*squeeze(inertiaRot(linkI,:,:));
            inertiaMat(i,:,:) = squeeze(inertiaRot(linkI,:,:))'*squeeze(modelInertia(i,:,:))*squeeze(inertiaRot(linkI,:,:));
        end
    end
    linkInertia = zeros(nLink,3,3);
    massProperties(1).mt = mt;
    massProperties(1).massVec = massVec;
    massProperties(1).inertiaMatBase = inertiaMatBase;
    massProperties(1).inertiaMat = inertiaMat;
    massProperties(1).linkInertia = linkInertia;

else
    armAttachPnt = [0 0 0];
    armAttachAngles = [0 0 0]*dtr;
    thetaOffset = [0 0 0]*dtr;
    DHparams(1,:) = [sat.service.radius sat.service.length/2 0.0*dtr Base_z];
% % %     DHparams(1,:) = [0 0 0.0*dtr Base_z];
    for i = 1:nLink
        DHparams(i+1,:) = [0.0 Link_Length(i) 0.0 q(i)+thetaOffset(i)];
    end

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
