function arm = configureViperX300Arm(arm,q,sat)
    dtr = pi/180;


    armAttachPnt = [0 0 0];
    armAttachAngles = [0 0 0]*dtr;
    thetaOffset = [0 90 -90 90 0]*dtr;

    % DH parameters order: [d a alpha theta]
    %         d:     distance along z axis
    %         a:     distance along x axis
    %         alpha: rotation about x axis
    %         theta: rotation about z axis
    % First row of DH table defined in test setup based on attach configuration
    DHparams(2,:) = [arm.Link_Length(1) 0.0  90.0*dtr q(1)+thetaOffset(1)];
    DHparams(3,:) = [0.0 arm.Link_Length(2)   0.0*dtr q(2)+thetaOffset(2)];
    DHparams(4,:) = [0.0 arm.Link_Length(3)  90.0*dtr q(3)+thetaOffset(3)];
    DHparams(5,:) = [0.0 arm.Link_Length(4)  90.0*dtr q(4)+thetaOffset(4)];
    DHparams(6,:) = [arm.Link_Length(5) 0.0   0.0*dtr q(5)+thetaOffset(5)];
    
    % Set up mass properties
    % THESE ARE PROBABLY INCORRECT. NEED TO MATCH THIS WITH ARM MODEL
    m_base = sat.service.mass + arm.smiData.Solid(1).mass;  % Sum satellite base and arm base
    for i = 1:arm.nLink
        m_link(i) = arm.smiData.Solid(i+1).mass;
    end
    mt = m_base + sum(m_link);
    massVec = [m_base m_link];
    
    % NEED TO ADD IN INERTIA OF ARM BASE (also check order of PoI variables)
    inertiaMatBase = [sat.service.MoI(1) sat.service.PoI(1) sat.service.PoI(2); ... 
                      sat.service.PoI(1) sat.service.MoI(2) sat.service.PoI(3); ...
                      sat.service.PoI(2) sat.service.PoI(3) sat.service.MoI(3)];
                  
    linkIdx = 1;
    for i = 1:arm.nLink
        inertiaMat(i,:,:) = [arm.smiData.Solid(i+linkIdx).MoI(1) arm.smiData.Solid(i+linkIdx).PoI(1) arm.smiData.Solid(i+linkIdx).PoI(2); ... 
                             arm.smiData.Solid(i+linkIdx).PoI(1) arm.smiData.Solid(i+linkIdx).MoI(2) arm.smiData.Solid(i+linkIdx).PoI(3); ...
                             arm.smiData.Solid(i+linkIdx).PoI(2) arm.smiData.Solid(i+linkIdx).PoI(3) arm.smiData.Solid(i+linkIdx).MoI(3)]/1000/1000; % Convert from kg*mm2 to kg*m2
    end
    linkInertia = zeros(arm.nLink,3,3);
    arm(1).massProperties.mt = mt;
    arm(1).massProperties.massVec = massVec;
    arm(1).massProperties.inertiaMatBase = inertiaMatBase;
    arm(1).massProperties.inertiaMat = inertiaMat;
    arm(1).massProperties.linkInertia = linkInertia;
    arm(1).thetaOffset = thetaOffset;
    arm(1).DHparams = DHparams;
    arm(1).thetaOffset = thetaOffset;
    arm(1).armAttachPnt = armAttachPnt;
    arm(1).armAttachAngles = armAttachAngles;

end