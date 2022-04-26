% function [rVec,pVec,rVec0,rBase,RL,RLbase,RJ,RJbase,kVec,T00,PoseMats] = computeGeometry(x0,nLink,Link_Length,massVec,Base_a)
function [geometry] = computeGeometry(x0,nLink,Link_Length,massVec,alpha,Base_a,Base_c,Base_z)

% Assumptions and Limitations:
%   Set up for a 3 joint system

% Author: Andrew Barth
%
% Modification History:
%    Oct 19 2018 - Initial version
%    Mar 15 2022 - Added array sizing for Simulink implementation
%

%global NLINKS
coder.extrinsic('Simulink.Bus') 
assert(nLink < 10);

DHparams = zeros(nLink+1,4);
RJb = zeros(nLink+1,3,3);
RJ  = zeros(nLink+1,3,3);
RL  = zeros(nLink,3,3);
rVec0 = zeros(nLink,3);
rVec  = zeros(nLink,3);
pVec  = zeros(nLink+1,3);
kVec  = zeros(nLink,3,1);
T00 = zeros(4,4);
PoseMats = zeros(4,4,nLink+1);

% Extract elements from state vector
rcm = x0(1:3)';
eulerAng = x0(4:6)';
q = x0(7:7+nLink-1);

Link_CG = Link_Length/2;

% Set up DH parameters
DHparams(1,:) = [Base_a Base_c/2 0.0 Base_z];
for i = 1:nLink
    DHparams(i+1,:) = [0.0 Link_Length(i) 0.0 q(i)];
end

% Call forward kinematics to compute pose matrices (relative to spacecraft)
PoseMats = fKinematics(DHparams,'all');

% Compute initial geometry
Rot_Inertial_To_SC = robotZRot(eulerAng(3))*robotYRot(eulerAng(2))*robotXRot(eulerAng(1));
T00 = [ [Rot_Inertial_To_SC(1:3,1:3) [0 0 0]']; [0 0 0 1] ];
T10 = [PoseMats(1:3,1:3,1) PoseMats(1:3,4,1); [0 0 0 1] ];
T20 = [PoseMats(1:3,1:3,2) PoseMats(1:3,4,2); [0 0 0 1] ];
T30 = [PoseMats(1:3,1:3,3) PoseMats(1:3,4,3); [0 0 0 1] ];
T40 = [PoseMats(1:3,1:3,4) PoseMats(1:3,4,4); [0 0 0 1] ];

% Rotation matrix from Joint i to Base frame
% Last element is rotation from End Effector to Base frame
RJbase = T00(1:3,1:3);
RJb(1,:,:) = T10(1:3,1:3);
RJb(2,:,:) = T20(1:3,1:3);
RJb(3,:,:) = T30(1:3,1:3);
RJb(4,:,:) = T40(1:3,1:3);

% Rotation matrix from Joint i to Inertial frame
% Last element is rotation from End Effector to Inertial frame
RJ(1,:,:)  = T00(1:3,1:3)*T10(1:3,1:3);
RJ(2,:,:)  = T00(1:3,1:3)*T20(1:3,1:3);
RJ(3,:,:)  = T00(1:3,1:3)*T30(1:3,1:3);
RJ(4,:,:)  = T00(1:3,1:3)*T40(1:3,1:3);

% Rotation matrix from Link i to Inertial frame
% Link frame i is the same as Joint frame i+1
RLbase = RJbase;
for i = 1:nLink
    RL(i,:,:) = RJ(i+1,:,:);
end

% Joint axis rotation vector of joint i in the Inertial frame
for i = 1:nLink
    kVec(i,:,1) = squeeze(RJ(i,:,:))*[0 0 1]';
end

% Define location for the cg of the link with respect to base
rVec0(1,:) = T00(1:3,1:3)*T10(1:3,4) + T00(1:3,1:3)*T20(1:3,1:3)*[Link_CG(1) 0 0]';
rVec0(2,:) = T00(1:3,1:3)*T20(1:3,4) + T00(1:3,1:3)*T30(1:3,1:3)*[Link_CG(2) 0 0]';
rVec0(3,:) = T00(1:3,1:3)*T30(1:3,4) + T00(1:3,1:3)*T40(1:3,1:3)*[Link_CG(3) 0 0]';

% Compute the system center of mass relative to the base
mt = sum(massVec);
msum = [0 0 0];
for i=1:nLink
    msum = msum + massVec(i+1)*rVec0(i,1:3,1);
end
rcmBase = msum / mt;

% Define location of base in the Inertial frame
rBase = rcm - rcmBase;

% Define location of joints with respect to origin
pVec(1,:) = rBase' + T00(1:3,1:3)*T10(1:3,4);
pVec(2,:) = rBase' + T00(1:3,1:3)*T20(1:3,4);
pVec(3,:) = rBase' + T00(1:3,1:3)*T30(1:3,4);
pVec(4,:) = rBase' + T00(1:3,1:3)*T40(1:3,4);

% Define location for the cg of the link with respect to origin
rVec(1,:) = rBase' + rVec0(1,:,1)';
rVec(2,:) = rBase' + rVec0(2,:,1)';
rVec(3,:) = rBase' + rVec0(3,:,1)';

alphaOut = alpha';

geometry.rBase = rBase;
geometry.rVec = rVec;
geometry.rVec0 = rVec0;
geometry.pVec = pVec;
geometry.RL = RL;
geometry.RLbase = RLbase;
geometry.RJ = RJ;
geometry.RJbase = RJbase;
geometry.kVec = kVec;
geometry.T00 = T00;
geometry.PoseMats = PoseMats;
geometry.alpha = alphaOut;

% geometry_bus_info = Simulink.Bus.createObject(geometry);
% geometry_bus = evalin('base', geometry_bus_info.busName);