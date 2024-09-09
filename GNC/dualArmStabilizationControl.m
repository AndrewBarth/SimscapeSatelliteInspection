function [momentum,desired_rates,desired_rates2,momentumDelta,Ho] = dualArmStabilizationControl(time,Hom1,geometry1,massProperties1,nLink1,Hom2,geometry2,massProperties2,nLink2,base_state,baseMP,arm1_state,arm2_state)

%function [momentum,desired_rates1,desired_rates2,desired_rates3,momentum2,roc] = computeMomentum(time,Hom1,geometry1,massProperties1,nLink1,Hom2,geometry2,massProperties2,nLink2,base_state,baseMP,arm1_state,arm2_state)

% Extract variables from structure for convenience
rBase1 = geometry1.rBase;
RLbase1 = geometry1.RLbase;
% RL1 = geometry1.RL;
% rVec1  = geometry1.rVec;
rVec01 = geometry1.rVec0;
% pVec1  = geometry1.pVec;
% kVec1  = geometry1.kVec;
massVec1 = massProperties1.massVec;
inertiaMatBase1 = massProperties1.inertiaMatBase;
linkInertia1 = massProperties1.linkInertia;

% rBase2 = geometry2.rBase;
% RLbase2 = geometry2.RLbase;
% RL2 = geometry2.RL;
% rVec2  = geometry2.rVec;
rVec02 = geometry2.rVec0;
% pVec2  = geometry2.pVec;
% kVec2  = geometry2.kVec;
massVec2 = massProperties2.massVec;
linkInertia2 = massProperties2.linkInertia;

% % Center of base the inertial frame
rBase = base_state(1:3)';
% 
% % Compute the vector from base to system center of mass

% % Contribution of the base
msum = baseMP(1) * baseMP(2:4)';
mt = baseMP(1);
% msum = [0 0 0];
for i=1:nLink1
    msum = msum + massVec1(i+1)*rVec01(i,1:3,1);
    mt = mt + massVec1(i+1);
end
for i=1:nLink2
    msum = msum + massVec2(i+1)*rVec02(i,1:3,1);
    mt = mt + massVec1(i+1);
end
% rcmBase = msum / mt;
% rcmSys = geometry1.rBase + msum / mt;  % Ref 1 Eq. 12
rcmSys =  msum / mt;  % Ref 1 Eq. 12

% roc = base_state(1:3)' - rBase1(:)';
% roc = geometry1.rcmSys;
% roc = rcmSys;
roc = msum / mt - baseMP(2:4)';
rocSkew = skewMat(roc);

% Base Mass
% mt = massVec1(1);

% Form the inertia matrix of the base - manipulator system
HsBase = RLbase1*inertiaMatBase1*RLbase1';

Hs1 = zeros(3,3);
Hs2 = zeros(3,3);

for i = 1:nLink1
    rSkew = skewMat(rVec01(i,:));
    Hs1 =  Hs1 + squeeze(linkInertia1(i,:,:)) - massVec1(i+1)*rSkew*rSkew;  % Ref 1, Eq. 29 
    % mt = mt + massVec1(i+1);
end
for i = 1:nLink2
    rSkew = skewMat(rVec02(i,:));
    Hs2 =  Hs2 + squeeze(linkInertia2(i,:,:)) - massVec2(i+1)*rSkew*rSkew;  % Ref 1, Eq. 29 
    % mt = mt + massVec2(i+1);
end
% mt = 6.0454;
% mt = 4.8965;
Hs = HsBase + Hs1 + Hs2;

% Form the base-spacecraft inertia matrix
Ho = [mt*eye(3,3) -mt*rocSkew; mt*rocSkew Hs];           % Ref 1, Eq. 28
% Ho = [mt*eye(3,3)  mt*rocSkew; -mt*rocSkew Hs];

% Compute linear and angular momentum     
momentum = Ho*base_state(7:end) + Hom1*arm1_state + Hom2*arm2_state;
           
[U,S,V]=svd(Hom2(1:6,:));
Hom2_approx=U(:,1)*S(1,1)*V(:,1)';

% rows = [2 4 5];
% rows = [1 2 3 4 5 6];
rows = [4 5 6]; % 2 Link center and top front

[U,S,V]=svd(Hom2(rows,:));
nsv = length(find(diag(S)>1e-3));
Hom2_svdapprox=U(:,1:nsv)*S(1:nsv,1:nsv)*V(:,1:nsv)';


% Compute desired rates for arm 2
desired_rates1 = -1*pinv(Hom2,1e-6)*(1*Ho*base_state(7:end) + Hom1*arm1_state);
desired_rates2 = -1*pinv(Hom2(4:6,:),1e-6)*(1*Ho(4:6,:)*base_state(7:end) + Hom1(4:6,:)*arm1_state);
desired_rates3 = -1*pinv(Hom2(4:6,:),1e-6)*(Hom1(4:6,:)*arm1_state);     % Used for 2 link configuration 1
% % % desired_rates3 = 1*pinv(Hom2_approx,1e-9)*(Hom1(1:6,:)*arm1_state);
% % % desired_rates3 = -1*pinv(Hom2_svdapprox,1e-6)*(Hom1(rows,:)*arm1_state);
% desired_rates3 = -1*pinv(Hom2_approx,1e-9)*(1*Ho*base_state(7:end) + Hom1*arm1_state);
desired_rates = -1*pinv(Hom2,1e-3)*(Hom1*arm1_state);  
% desired_rates3 = -1*pinv(Hom2(6,:),1e-6)*(Hom1(6,:)*arm1_state);
% desired_rates3 = -1*pinv(Hom2(6,:),1e-6)*(1*Ho(6,:)*base_state(7:end) + Hom1(6,:)*arm1_state);
% desired_rates3 = -1*pinv(Hom2([1 6],:),1e-6)*(Ho([1 6],:)*base_state(7:end) + Hom1([1 6],:)*arm1_state);


options = optimoptions('fsolve','Algorithm','Levenberg-Marquardt');
x0 = arm2_state;
fun = @(x)paramfun(x,Ho,base_state,Hom1,arm1_state,Hom2_svdapprox,rows); 
x = fsolve(fun,x0,options);

function F = paramfun(arm2_state,Ho,base_state,Hom1,arm1_state,Hom2,rows)
    % F = Ho*base_state(7:end) + Hom1*arm1_state + Hom2*arm2_state;
    % F = Ho(4:6,:)*base_state(7:end) + Hom1(4:6,:)*arm1_state + Hom2(4:6,:)*arm2_state;
    % F = norm(Hom1(6:6,:)*arm1_state + Hom2(6:6,:)*arm2_state);
    F = norm(Hom1(rows,:)*arm1_state + Hom2*arm2_state);
end
desired_rates2 = desired_rates3;
% desired_rates3 = x;

% desired_rates=desired_rates2;
desired_rates=desired_rates3;

momentumNew = Ho*base_state(7:end) + Hom1*arm1_state + Hom2*desired_rates3;
momentumDelta = momentumNew-momentum;   
% momentumDelta=cond(Hom2);


end