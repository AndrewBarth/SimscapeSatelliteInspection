function [momentum,desired_rates] = dualArmStabilizationControl(time,Hom1,geometry1,massProperties1,nLink1,Hom2,geometry2,massProperties2,nLink2,base_state,arm1_rates,arm2_rates)

% Extract variables from structure for convenience
rBase1 = geometry1.rBase;
RLbase1 = geometry1.RLbase;
rVec01 = geometry1.rVec0;
massVec1 = massProperties1.massVec;
inertiaMatBase1 = massProperties1.inertiaMatBase;
linkInertia1 = massProperties1.linkInertia;

% rBase2 = geometry2.rBase;
rVec02 = geometry2.rVec0;
massVec2 = massProperties2.massVec;
linkInertia2 = massProperties2.linkInertia;

% Compute the vector from base to system center of mass
roc = base_state(1:3)' - rBase1(:)';
rocSkew = skewMat(roc);

% Mass of base
mt = massVec1(1);

% Form the inertia matrix of the base - manipulator system
HsBase = RLbase1*inertiaMatBase1*RLbase1';

Hs1 = zeros(3,3);
Hs2 = zeros(3,3);

for i = 1:nLink1
    rSkew = skewMat(rVec01(i,:));
    Hs1 = squeeze(linkInertia1(i,:,:)) - massVec1(i+1)*rSkew*rSkew;  % Ref 1, Eq. 29 
    mt = mt + massVec1(i+1);
end
for i = 1:nLink2
    rSkew = skewMat(rVec02(i,:));
    Hs2 = squeeze(linkInertia2(i,:,:)) - massVec2(i+1)*rSkew*rSkew;  % Ref 1, Eq. 29 
    mt = mt + massVec2(i+1);
end

Hs = HsBase + Hs1 + Hs2;

% Form the base-spacecraft inertia matrix
Ho = [mt*eye(3,3) -mt*rocSkew; mt*rocSkew Hs];           % Ref 1, Eq. 28

% Compute linear and angular momentum     
momentum = Ho*base_state(7:end) + Hom1*arm1_rates + Hom2*arm2_rates;

% Compute desired rates for arm 2
% desired_rates = -1*pinv(Hom2,1e-6)*(1*Ho*base_state(7:end) + Hom1*arm1_rates);
% desired_rates = -1*pinv(Hom2(4:6,:))*(-1*Ho(4:6,:)*base_state(7:end) + Hom1(4:6,:)*arm1_rates);
desired_rates = -1*pinv(Hom2(4:6,:),1e-6)*(Hom1(4:6,:)*arm1_rates);
% desired_rates = -1*pinv(Hom2,1e-6)*(Hom1*arm1_rates);                               
                                