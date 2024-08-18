function [geometry] = computeGeometry(x0,nLink,Link_CG,massVec,alpha,thetaOffset,DHparams,attachPnt,attachAngles)
% Function to compute the system geometry based on the current joint angles
% and arm configuration
%
% Inputs: x0:            state vector [position eulerAngles jointAngles
%                                      velocity angularRate jointRates]
%         nLink:         number of links in arm
%         Link_CG:       vector of locations of link CGs
%         massVec:       vector of masses (base and links)
%         alpha:         alpha angle for DH parameters
%         thetaOffset:   offset for the theta angle in the DH parameters
%         DHparams:      Denavit-Hartenberg parameters for the arm
%         attachPnt:     location of the arm attach point relative to the base
%         attachAngles:  rotation of the arm attach point relative to the base
%
% Output: geometry:      structure containing geometry parameters
%
% Assumptions and Limitations:
%   Not set up to handle prismatic joints
%
% Dependencies:
%   fKinematics
%   robotXRot, robotYRot, robotZRot
%
% References:
%    1. Wilde, Markus, et al. "Equations of Motion of Free-Floating 
%          Spacecraft-Manipulator Systems: An Engineer's Tutorial." 
%          Frontiers in Robotics and AI 5 (2018): 41.
%
% Author: Andrew Barth
%
% Modification History:
%    Oct 19 2018 - Initial version
%    Mar 15 2022 - Added array sizing for Simulink implementation
%    Aug 29 2022 - Generalized to support a variable number of links
%    Sep 19 2022 - Added offset angle for theta angle
%    Dec 12 2022 - Changed to input link CG directly
%    Jan 11 2023 - Different method to compute Pose matrices

coder.extrinsic('Simulink.Bus') 
assert(nLink < 10);

% Initialize data sizes
RJb = zeros(nLink+1,3,3);
RJ  = zeros(nLink+1,3,3);
RL  = zeros(nLink,3,3);
rVec0 = zeros(nLink,3);
rVec  = zeros(nLink,3);
pVec  = zeros(nLink+1,3);
kVec  = zeros(nLink,3,1);
Tmat = zeros(nLink+2,4,4);
PoseMats = zeros(4,4,nLink+1);

% Extract elements from state vector
% rcm = x0(1:3)';
rBase = x0(1:3)';
eulerAng = x0(4:6)';
q = x0(7:7+nLink-1);

if size(DHparams,1) > nLink
    % Update joint angles in DH parameters
    for i = 1:nLink
        DHparams(i+1,4) = q(i)+thetaOffset(i);
    end
else
    % Update joint angles in DH parameters
    for i = 1:nLink
        DHparams(i,4) = q(i)+thetaOffset(i);
    end
end

% Call forward kinematics to compute pose matrices (relative to spacecraft)
basePoseMats = zeros(4,4,nLink+1);
basePoseMats = fKinematics(DHparams,'all');
attachMat = EulerToDCM_321(attachAngles)'; 
attachPose = [ [attachMat [attachPnt]]; [0 0 0 1] ];
for i=1:nLink+1    
    PoseMats(:,:,i) = attachPose*basePoseMats(:,:,i);
end

% Compute initial geometry

% Begin with rotation matrix of Base to Inertial frame
Rot_Inertial_To_SC = robotZRot(eulerAng(3))*robotYRot(eulerAng(2))*robotXRot(eulerAng(1));
Tmat(1,:,:) = [ [Rot_Inertial_To_SC(1:3,1:3) [0 0 0]']; [0 0 0 1] ];    % Ref 1, Eq. 7

% Rotation from Joint to Base frame (and End Effector to Base)
for i = 1:nLink+1
    Tmat(i+1,:,:) = [PoseMats(1:3,1:3,i) PoseMats(1:3,4,i); [0 0 0 1] ];
end

% Rotation matrix from Joint i to Base frame
% Last element is rotation from End Effector to Base frame
RJbase = squeeze(Tmat(1,1:3,1:3));
for i = 1:nLink+1
    RJb(i,:,:) = squeeze(Tmat(1+i,1:3,1:3));
end

% Rotation matrix from Joint i to Inertial frame
% Last element is rotation from End Effector to Inertial frame
% ALB: Isn't this actually Inertial to Joint????
for i = 1:nLink+1
    RJ(i,:,:) = squeeze(Tmat(1,1:3,1:3))*squeeze(Tmat(i+1,1:3,1:3));
end

% Rotation matrix from Link i to Inertial frame
% Link frame i is the same as Joint frame i+1
RLbase = RJbase;
for i = 1:nLink
    RL(i,:,:) = RJ(i+1,:,:);      % Ref 1, Eq. 4
end

% Joint axis rotation vector of joint i in the Inertial frame
for i = 1:nLink
    kVec(i,:,1) = squeeze(RJ(i,:,:))*[0 0 1]';    % Ref 1, Eq. 5
end

% Define location for the cg of the link with respect to cg of base
for i=1:nLink
   rVec0(i,:) = squeeze(Tmat(1,1:3,1:3))*Tmat(i+1,1:3,4)' + ...
                squeeze(RJ(i+1,:,:))*Link_CG(i,:)';
   % rVec0(i,:) = squeeze(Tmat(1,1:3,1:3))*(Tmat(i+1,1:3,4)' + ...
   %              squeeze(RJ(i+1,:,:))*Link_CG(i,:)');
end

% Compute the system center of mass relative to the base
mt = sum(massVec);
msum = [0 0 0];
for i=1:nLink
    msum = msum + massVec(i+1)*rVec0(i,1:3,1);
end
% rcmBase = msum / mt;
rcmSys = rBase + msum / mt;  % Ref 1 Eq. 12

% Define location of base in the Inertial frame
% rBase = rcm - rcmBase;

% Define location of joints with respect to origin
for i = 1:nLink+1
   pVec(i,:) = rBase' + squeeze(Tmat(1,1:3,1:3))*Tmat(i+1,1:3,4)';
end

% Define location for the cg of the link with respect to origin
for i = 1:nLink
    rVec(i,:) = rBase' + rVec0(i,:)';
end

alphaOut = alpha';

% Store data in geometry structure
geometry.rBase = rBase;
geometry.rVec = rVec;
geometry.rVec0 = rVec0;
geometry.pVec = pVec;
geometry.RL = RL;
geometry.RLbase = RLbase;
geometry.RJ = RJ;
geometry.RJbase = RJbase;
geometry.kVec = kVec;
geometry.T00 = squeeze(Tmat(1,:,:));
geometry.PoseMats = PoseMats;
geometry.alpha = alphaOut;
geometry.rcmSys = rcmSys;

