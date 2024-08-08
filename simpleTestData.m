

stepSize = 0.001;



arm(1).dimension = [.1 .5 .1];
arm(1).mass = 1;
arm(1).com = [0 0 0];
arm(1).moi = [0.02 0.001 0.02];
arm(1).poi = [0 0 0];

arm(2).dimension = [.1 .5 .1];
arm(2).mass = 1;
arm(2).com = [0 0 0];
arm(2).moi = [0.02 0.001 0.02];
arm(2).poi = [0 0 0];


arm(1).IC.angles = [0.0];
arm(2).IC.angles = [0.0];

temp1 = rmfield(arm(1),'DHparams');
temp2 = rmfield(arm(2),'DHparams');
clear arm
arm(1) = temp1;
arm(2) = temp2;

arm(1).massProperties = rmfield(arm(1).massProperties,'inertiaMat');
arm(1).massProperties = rmfield(arm(1).massProperties,'linkInertia');
arm(1).Link_Length = 0.5;
arm(1).Link_CG = [0.25 0 0];
arm(1).thetaOffset = -90*pi/180;
arm(1).DHparams(1,:) = [0 0 0 0];
arm(1).DHparams(2,:) = [0.0 arm(1).Link_Length/2 0.0 0.0+arm(1).thetaOffset] ;
% arm(1).armAttachPnt = [-0.5 -0.5 0.5];
arm(1).armAttachPnt = [0 -0.5 0];
arm(1).armAttachAngles = [0 0 0]*pi/180;

arm(1).massProperties.mt = 3;
arm(1).massProperties.massVec = [2 1];
arm(1).massProperties.inertiaMatBase = diag([1/3 1/3 1/3]);
% arm(1).massProperties.inertiaMat(1,:,:) = [0.02 0 0; 0 0.001 0; 0 0 0.02];
arm(1).massProperties.inertiaMat(1,:,:) = [0.001 0 0; 0 0.02 0; 0 0 0.02];
arm(1).massProperties.linkInertia(1,:,:) = zeros(3,3);
arm(1).nLink = 1;

arm(2).massProperties = rmfield(arm(2).massProperties,'inertiaMat');
arm(2).massProperties = rmfield(arm(2).massProperties,'linkInertia');
arm(2).Link_Length = 0.5;
arm(2).Link_CG = [0.25 0 0];
arm(2).thetaOffset = 90*pi/180;
arm(2).DHparams(1,:) = [0 0 0 0];
arm(2).DHparams(2,:) = [0.0 arm(2).Link_Length/2 0.0 0.0+arm(2).thetaOffset] ;
% arm(2).armAttachPnt = [-0.5 0.5 0.5];
arm(2).armAttachPnt = [0 0.5 0];
arm(2).armAttachAngles = [0 0 0]*pi/180;

arm(2).massProperties.mt = 3;
arm(2).massProperties.massVec = [2 1];
arm(2).massProperties.inertiaMatBase = diag([1/3 1/3 1/3]);
% arm(2).massProperties.inertiaMat(1,:,:) = [0.02 0 0; 0 0.001 0; 0 0 0.02];
arm(2).massProperties.inertiaMat(1,:,:) = [0.001 0 0; 0 0.02 0; 0 0 0.02];
arm(2).massProperties.linkInertia(1,:,:) = zeros(3,3);
arm(2).nLink = 1;


jointControlData.Kp = [1 1 1 ]*1000.0;
jointControlData.Kd = [1 1 1 ]*0.0001;
jointControlData.Ki = [1 1 1 ]*10.;

alpha = 0;
nLink = 1;
loadBusData

% Define a Simulink parameter to store the number of links
% This was necessary for Simulink to allow arrays to be sized by nLink
NLINKS = Simulink.Parameter;
NLINKS.Value = 1;
NLINKS.CoderInfo.StorageClass = 'Auto';
NLINKS.CoderInfo.Alias = '';
NLINKS.CoderInfo.Alignment = -1;
NLINKS.CoderInfo.CustomStorageClass = 'Define';
NLINKS.CoderInfo.CustomAttributes.HeaderFile = '';
NLINKS.CoderInfo.CustomAttributes.ConcurrentAccess = false;
NLINKS.CoderInfo.Alias = '';
NLINKS.CoderInfo.Alignment = -1;
NLINKS.Description = 'The number of links';
NLINKS.DataType = 'uint8';
NLINKS.Min = [];
NLINKS.Max = [];
NLINKS.DocUnits = '';

clear temp
