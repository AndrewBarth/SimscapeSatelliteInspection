

% Note that the state being set to 'Input' should be set first so that the
% signal lines do not get disconnected because both were set to "Computed'
if ARM_TYPE == 0
    if JOINT_COMMAND_SOURCE == 0
        % Configure the joints to accept torque input when in active control mode
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmPlanar3Link/Joint 1','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmPlanar3Link/Joint 1','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
      
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmPlanar3Link/Joint 2','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmPlanar3Link/Joint 2','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
        
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmPlanar3Link/Joint 3','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmPlanar3Link/Joint 3','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
    else
        % Configure the joints to accept motion input when in playback mode
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmPlanar3Link/Joint 1','MotionActuationMode','InputMotion');      % 'InputMotion' , 'ComputedMotion'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmPlanar3Link/Joint 1','TorqueActuationMode','ComputedTorque');   % 'InputTorque' , 'ComputedTorque'
        
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmPlanar3Link/Joint 2','MotionActuationMode','InputMotion');      % 'InputMotion' , 'ComputedMotion'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmPlanar3Link/Joint 2','TorqueActuationMode','ComputedTorque');   % 'InputTorque' , 'ComputedTorque'
        
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmPlanar3Link/Joint 3','MotionActuationMode','InputMotion');      % 'InputMotion' , 'ComputedMotion'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmPlanar3Link/Joint 3','TorqueActuationMode','ComputedTorque');   % 'InputTorque' , 'ComputedTorque'
    end
elseif ARM_TYPE == 5
    if JOINT_COMMAND_SOURCE == 0
        % Configure the joints to accept torque input when in active control mode
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ShoulderAssm_1/Joint_1','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ShoulderAssm_1/Joint_1','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'

        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ShoulderAssm_1/Joint_2','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ShoulderAssm_1/Joint_2','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
        
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ShoulderAssm_1/Joint_3','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ShoulderAssm_1/Joint_3','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
    
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ElbowAssem_1/Joint_4','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ElbowAssem_1/Joint_4','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
    
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ElbowAssem_1/Joint_5','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ElbowAssem_1/Joint_5','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
    
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/WristAssem_1/Joint_6','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/WristAssem_1/Joint_6','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
    
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/WristAssem_1/Joint_7','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/WristAssem_1/Joint_7','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
    else
        % Configure the joints to accept motion input when in playback mode
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ShoulderAssm_1/Joint_1','MotionActuationMode','InputMotion');      % 'InputMotion' , 'ComputedMotion'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ShoulderAssm_1/Joint_1','TorqueActuationMode','ComputedTorque');   % 'InputTorque' , 'ComputedTorque'
    
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ShoulderAssm_1/Joint_2','MotionActuationMode','InputMotion');      % 'InputMotion' , 'ComputedMotion'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ShoulderAssm_1/Joint_2','TorqueActuationMode','ComputedTorque');   % 'InputTorque' , 'ComputedTorque'

        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ShoulderAssm_1/Joint_3','MotionActuationMode','InputMotion');      % 'InputMotion' , 'ComputedMotion'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ShoulderAssm_1/Joint_3','TorqueActuationMode','ComputedTorque');   % 'InputTorque' , 'ComputedTorque'
    
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ElbowAssem_1/Joint_4','MotionActuationMode','InputMotion');      % 'InputMotion' , 'ComputedMotion'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ElbowAssem_1/Joint_4','TorqueActuationMode','ComputedTorque');   % 'InputTorque' , 'ComputedTorque'
    
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ElbowAssem_1/Joint_5','MotionActuationMode','InputMotion');      % 'InputMotion' , 'ComputedMotion'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/ElbowAssem_1/Joint_5','TorqueActuationMode','ComputedTorque');   % 'InputTorque' , 'ComputedTorque'

        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/WristAssem_1/Joint_6','MotionActuationMode','InputMotion');      % 'InputMotion' , 'ComputedMotion'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/WristAssem_1/Joint_6','TorqueActuationMode','ComputedTorque');   % 'InputTorque' , 'ComputedTorque'
    
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/WristAssem_1/Joint_7','MotionActuationMode','InputMotion');      % 'InputMotion' , 'ComputedMotion'
        set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/LeftArm/WristAssem_1/Joint_7','TorqueActuationMode','ComputedTorque');   % 'InputTorque' , 'ComputedTorque'
    end
    % Configure the joints to accept torque input when in active control mode
    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/ShoulderAssm_1/Joint_1','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/ShoulderAssm_1/Joint_1','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'

    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/ShoulderAssm_1/Joint_2','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/ShoulderAssm_1/Joint_2','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
    
    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/ShoulderAssm_1/Joint_3','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/ShoulderAssm_1/Joint_3','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'

    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/ElbowAssem_1/Joint_4','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/ElbowAssem_1/Joint_4','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'

    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/ElbowAssem_1/Joint_5','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/ElbowAssem_1/Joint_5','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'

    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/WristAssem_1/Joint_6','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/WristAssem_1/Joint_6','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'

    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/WristAssem_1/Joint_7','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
    set_param('SatelliteServicing_Mission/Mission/Robotic_Arm/RoboticArm/RoboticArmDualArms/RightArm/WristAssem_1/Joint_7','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
end



% NEED TO ADD PLAYBACK MODE FOR OTHER ARM MODELS