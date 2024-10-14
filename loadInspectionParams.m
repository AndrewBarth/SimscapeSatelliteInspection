
% Size of Goldberg polyhedron
% GBa = 4;
GBa = 2;
GBb = 2;
% GBa = 3;
% GBb = 3;
 % GBa = 1;
 % GBb = 1;

% Use golden ratio for radius
PHI = (1+sqrt(5)) / 2;
radius = norm([PHI 1 0]);

% radius=5;

makePlots = 1;
[faceCenter,faceRadius,GPData] = formGoldbergPolyhedron(GBa,GBb,radius,makePlots);

% Store parameters in client data structure
client.faceCenter = faceCenter;
client.faceRadius = faceRadius;
client.inspectionSphereRadius = radius;
client.nFaces = length(faceCenter);

client.inspectionFOV = [50 50 50 50]*pi/180;

