
tVal=[80 90 20]*pi/180;
% tVal=[0 0 0]*pi/180;
aVal=[.2 .2 .08];


s1=sin(tVal(1));
c1=cos(tVal(1));
s12=sin(tVal(1)+tVal(2));
c12=cos(tVal(1)+tVal(2));
s123=sin(tVal(1)+tVal(2)+tVal(3));
c123=cos(tVal(1)+tVal(2)+tVal(3));

jVal = [-aVal(1)*s1-aVal(2)*s12-aVal(3)*s123 -aVal(2)*s12-aVal(3)*s123 -aVal(3)*s123; ...
         aVal(1)*c1+aVal(2)*c12+aVal(3)*c123  aVal(2)*c12+aVal(3)*c123  aVal(3)*c123; ...
         0 0 0; ...
         0 0 0; ...
         0 0 0; ...
         1 1 1]

p0 = [0 0 0];
p1 = [aVal(1)*c1 aVal(1)*s1 0];
p2 = [aVal(1)*c1+aVal(2)*c12 aVal(1)*s1+aVal(2)*s12 0];
p3 = [aVal(1)*c1+aVal(2)*c12+aVal(3)*c123 aVal(1)*s1+aVal(2)*s12+aVal(3)*s123 0];
apVec = [p0; p1; p2; p3]