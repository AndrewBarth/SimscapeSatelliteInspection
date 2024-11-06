% Define default parameters for the ViperX 300 arm

NLINKS.Value = 5;
arm(1).nLink = 5;
arm(2).nLink = 0;

% Data Trossen Robotics URDF File
Base_height = 79.00 / 1000;
waist_offset = [0, 0, 0.079];
shoulder_offset = [0, 0, 0.04805];
elbow_offset = [0.05955, 0, 0.3];
wrist_rotate_offset = [0.069744, 0, 0];
gripper_link_offset = [0.042825, 0, 0];
gripper_origin_offset = [0.005675, 0, 0];
gripper_bar_offset = [0.025875, 0, 0];
ee_gripper_origin_offset = [0.0385, 0, 0];
ee_offset = wrist_rotate_offset + gripper_link_offset + ...
            gripper_origin_offset + gripper_bar_offset + ...
            ee_gripper_origin_offset;
arm(1).Link_Length(1) = 126.75 / 1000 - Base_height;
arm(1).Link_Length(2) = 300.00 / 1000;
arm(1).Link_Length(3) = 300.00 / 1000 + elbow_offset(1);
arm(1).Link_Length(4) = 0.0 / 1000;
arm(1).Link_Length(5) = ee_offset(1);

arm(1).Link_CG(1,:) = [arm(1).Link_Length(1)/2 0 0];
arm(1).Link_CG(2,:) = [arm(1).Link_Length(2)/2 0 0];
arm(1).Link_CG(3,:) = [arm(1).Link_Length(3)/2 0 0];
arm(1).Link_CG(4,:) = [arm(1).Link_Length(4)/2 0 0];
arm(1).Link_CG(5,:) = [arm(1).Link_Length(5)/2 0 0];

arm(1).Joint_Limits(1,:) = [-pi pi];
arm(1).Joint_Limits(2,:) = [-1.850049007113989 1.256637061435917];
arm(1).Joint_Limits(3,:) = [-1.762782544514273 1.605702911834783];
arm(1).Joint_Limits(4,:) = [-1.867502299633933 2.234021442552742];
arm(1).Joint_Limits(5,:) = [-pi pi];