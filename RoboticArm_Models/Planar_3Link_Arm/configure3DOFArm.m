function arm = configure3DOFArm(arm,q,sat)

    dtr = pi/180;

    armAttachPnt = [0 0 0];
    armAttachAngles = [0 0 0]*dtr;

    Base_z = 90*dtr;   % Rotation becase Y axis is the joint axis
    % Base_z = 0;
    thetaOffset = [0 0 0]*dtr;
    DHparams(1,:) = [sat.service.radius sat.service.length/2 0.0*dtr Base_z];

    for i = 1:arm.nLink
        DHparams(i+1,:) = [0.0 arm.Link_Length(i) 0.0 q(i)+thetaOffset(i)];
    end

    % Set up mass properties
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