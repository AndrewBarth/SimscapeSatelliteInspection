

% Size of Goldberg polyhedron
a = 2;
b = 1;

% Use golden ratio for radius
PHI = (1+sqrt(5)) / 2;
radius = norm([PHI 1 0]);

makePlots = 1;
[faceCenter,faceRadius,GPData] = formGoldbergPolyhedron(a,b,radius,makePlots);