function arm = configure2DOFArm(arm,q,sat)

    dtr = pi/180;

    armAttachPnt = [0 0 0];
    armAttachAngles = [0 0 0]*dtr;

    Base_z = 90*dtr;   % Rotation becase Y axis is the joint axis
    Base_z = 0;
    thetaOffset = [0 0]*dtr;
    DHparams(1,:) = [sat.service.radius sat.service.length/2 0.0*dtr Base_z];

    for i = 1:arm.nLink
        DHparams(i+1,:) = [0.0 arm.Link_Length(i) 0.0 q(i)+thetaOffset(i)];
    end

    % Set up mass properties
    % This case is using the 1st and 3rd links from a 3-link arm model so
    % it is setting up mass properties link-by-link
    m_base = sat.service.mass + arm.smiData.Solid(1).mass;  % Sum satellite base and arm base
 
    m_link(1) = arm.smiData.Solid(2).mass;
    m_link(2) = arm.smiData.Solid(4).mass;

    mt = m_base + sum(m_link);
    massVec = [m_base m_link];
    
    % NEED TO ADD IN INERTIA OF ARM BASE (also check order of PoI variables)
    inertiaMatBase = [sat.service.MoI(1) sat.service.PoI(1) sat.service.PoI(2); ... 
                      sat.service.PoI(1) sat.service.MoI(2) sat.service.PoI(3); ...
                      sat.service.PoI(2) sat.service.PoI(3) sat.service.MoI(3)];
                  
    linkIdx = 1;

    inertiaMat(1,:,:) = [arm.smiData.Solid(2).MoI(1) arm.smiData.Solid(2).PoI(1) arm.smiData.Solid(2).PoI(2); ... 
                         arm.smiData.Solid(2).PoI(1) arm.smiData.Solid(2).MoI(2) arm.smiData.Solid(2).PoI(3); ...
                         arm.smiData.Solid(2).PoI(2) arm.smiData.Solid(2).PoI(3) arm.smiData.Solid(2).MoI(3)]/1000/1000; % Convert from kg*mm2 to kg*m2
    inertiaMat(2,:,:) = [arm.smiData.Solid(4).MoI(1) arm.smiData.Solid(4).PoI(1) arm.smiData.Solid(4).PoI(2); ... 
                         arm.smiData.Solid(4).PoI(1) arm.smiData.Solid(4).MoI(2) arm.smiData.Solid(4).PoI(3); ...
                         arm.smiData.Solid(4).PoI(2) arm.smiData.Solid(4).PoI(3) arm.smiData.Solid(4).MoI(3)]/1000/1000; % Convert from kg*mm2 to kg*m2
 
    linkInertia = zeros(arm.nLink,3,3);
    arm.massProperties.mt = mt;
    arm.massProperties.massVec = massVec;
    arm.massProperties.inertiaMatBase = inertiaMatBase;
    arm.massProperties.inertiaMat = inertiaMat;
    arm.massProperties.linkInertia = linkInertia;
    arm.thetaOffset = thetaOffset;
    arm.DHparams = DHparams;
    arm.thetaOffset = thetaOffset;
    arm.armAttachPnt = armAttachPnt;
    arm.armAttachAngles = armAttachAngles;

end