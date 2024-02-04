



% Note that the state being set to 'Input' should be set first so that the
% signal lines do not get disconnected because both were set to "Computed'

if JOINT_COMMAND_SOURCE == 0 && ARM_TYPE == 0
    % Configure the joints to accept torque input when in active control mode
    set_param('SatelliteServicing_Mission/RoboticArm/RoboticArmPlanar3Link/Joint 1','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
    set_param('SatelliteServicing_Mission/RoboticArm/RoboticArmPlanar3Link/Joint 1','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
  
    set_param('SatelliteServicing_Mission/RoboticArm/RoboticArmPlanar3Link/Joint 2','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
    set_param('SatelliteServicing_Mission/RoboticArm/RoboticArmPlanar3Link/Joint 2','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
    
    set_param('SatelliteServicing_Mission/RoboticArm/RoboticArmPlanar3Link/Joint 3','TorqueActuationMode','InputTorque');      % 'InputTorque' , 'ComputedTorque'
    set_param('SatelliteServicing_Mission/RoboticArm/RoboticArmPlanar3Link/Joint 3','MotionActuationMode','ComputedMotion');   % 'InputMotion' , 'ComputedMotion'
else
    % Configure the joints to accept motion input when in playback mode
    set_param('SatelliteServicing_Mission/RoboticArm/RoboticArmPlanar3Link/Joint 1','MotionActuationMode','InputMotion');      % 'InputMotion' , 'ComputedMotion'
    set_param('SatelliteServicing_Mission/RoboticArm/RoboticArmPlanar3Link/Joint 1','TorqueActuationMode','ComputedTorque');   % 'InputTorque' , 'ComputedTorque'
    
    set_param('SatelliteServicing_Mission/RoboticArm/RoboticArmPlanar3Link/Joint 2','MotionActuationMode','InputMotion');      % 'InputMotion' , 'ComputedMotion'
    set_param('SatelliteServicing_Mission/RoboticArm/RoboticArmPlanar3Link/Joint 2','TorqueActuationMode','ComputedTorque');   % 'InputTorque' , 'ComputedTorque'
    
    set_param('SatelliteServicing_Mission/RoboticArm/RoboticArmPlanar3Link/Joint 3','MotionActuationMode','InputMotion');      % 'InputMotion' , 'ComputedMotion'
    set_param('SatelliteServicing_Mission/RoboticArm/RoboticArmPlanar3Link/Joint 3','TorqueActuationMode','ComputedTorque');   % 'InputTorque' , 'ComputedTorque'
end

% NEED TO ADD PLAYBACK MODE FOR OTHER ARM MODELS