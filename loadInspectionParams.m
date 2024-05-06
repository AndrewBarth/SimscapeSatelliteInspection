
% Size of Goldberg polyhedron
a = 4;
b = 2;

% Use golden ratio for radius
PHI = (1+sqrt(5)) / 2;
radius = norm([PHI 1 0]);

makePlots = 0;
[faceCenter,faceRadius,GPData] = formGoldbergPolyhedron(a,b,radius,makePlots);

% Store parameters in client data structure
client.faceCenter = faceCenter;
client.faceRadius = faceRadius;
client.inspectionSphereRadius = radius;
client.nFaces = length(faceCenter);

client.inspectionFOV = 50*pi/180;

