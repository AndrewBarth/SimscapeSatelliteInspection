function [outputState,Pnew,K] = massPropRotEKF(inputState,dt,Pold,Q,measurements,controlInputs,massProperties,pNoise,mNoise)
% Equations for a Kalman filter implementation to estimate states for 
% linear position, linear velocity, angular position and angular velocity
% based on measurements of linear position, angular position, angular
% velocity and linear acceleration
%
% Inputs: input state    current estimated state [x y theta vx vy thetaDot] 6x1
%         dt             time step (s)  
%         Pold           previous covariance matrix 6x6
%         Q              process noise matrix
%         measurements   current measured state [x y theta thetaDot ax ay] 6x1 
%         controlInputs  current control inputs [fx fy mz] 3x1
%         massProperties [mass inertia] 2x1
%         pNoise         process noise value 1x1
%         mNoise         measurement noise value 6x1 
%
% Output: outputState    next estimated state [x y theta vx vy thetaDot] 6x1
%         Pnew           next covariance matrix 6x6
%         K              Kalman gain matrix
%
% Assumptions and Limitations:
%    None
%
% Dependencies:
%
% References:
%    Zarchan, Paul, and Howard Musoff. Fundamentals of Kalman Filtering: 
%    A Practical Approach, Fourth Edition, Aerospace Research Council, 2013.
%
% Author: Andrew Barth
%
% Modification History:
%    Dec 1  2019 - Initial version
%

% Parse Estimated State Data
wb = inputState(1:3);
qb = inputState(4:7);
I1 = inputState(8);
I2 = inputState(9);
I3 = inputState(10);
qd = inputState(11:14);

u = [controlInputs(1) controlInputs(2) controlInputs(3) ...
     controlInputs(1) controlInputs(2) controlInputs(3)]';

phis = pNoise;

m = massProperties(1);
J = massProperties(2);


% Compute fundamental matrix (phi)
F = [ 0                (I2-I3)/I1*wb(3)  (I2-I3)/I1*wb(2)  0          0          0          0         -(I2-I3)/I1^2*wb(2)*wb(3) wb(2)*wb(3)/I1 -wb(2)*wb(3)/I1 zeros(1,4); ...
      (I3-I1)/I2*wb(3) 0                 (I3-I1)/I2*wb(1)  0          0          0          0         -wb(1)*wb(3)/I2 -(I3-I1)/I2^2*wb(1)*wb(2) wb(1)*wb(3)/I2 zeros(1,4); ...
      (I1-I2)/I3*wb(2) (I1-I2)/I3*wb(1)  0                 0          0          0          0         wb(1)*wb(2)/I3 -wb(1)*wb(2)/I3 -(I1-I2)/I3^2*wb(1)*wb(2) zeros(1,4); ...
     -0.5*qb(2)       -0.5*qb(3)        -0.5*qb(4)         0         -0.5*wb(1) -0.5*wb(2) -0.5*wb(3) zeros(1,7); ...
      0.5*qb(1)       -0.5*qb(4)         0.5*qb(3)         0.5*wb(1)  0          0.5*wb(3) -0.5*wb(2) zeros(1,7); ...
      0.5*qb(4)        0.5*qb(1)        -0.5*qb(2)         0.5*wb(2) -0.5*wb(3)  0          0.5*wb(1) zeros(1,7); ...
     -0.5*qb(3)        0.5*qb(2)         0.5*qb(1)         0.5*wb(3)  0.5*wb(2) -0.5*wb(1)  0         zeros(1,7); ...
      zeros(7,14)];
% Taylor series expansion
phi = eye(size(F)) + F*dt + (F*dt)^2/2;
%phi = F;
% 
% % Comute discrete control matrix (G)
% G = [dt^2/(2*m) dt^2/(2*m) dt^2/(2*J) dt/m dt/m dt/J]';
% 
% % Compute process noise (Q)
% t3 = dt^3/3;
% t2 = dt^2/2;
% Q = phis* [dt^3/3  0       0       dt^2/2  0       0;      ...
%            0       dt^3/3  0       0       dt^2/2  0;      ...
%            0       0       dt^3/3  0       0       dt^2/2; ...
%            dt^2/2  0       0       dt      0       0;      ...
%            0       dt^2/2  0       0       dt      0;      ...
%            0       0       dt^2/2  0       0       dt];
% 
% Compute measurement matrix (H)
H = [0 0 0  qd(1)  qd(2)  qd(3)  qd(4) 0 0 0 0 0 0 0; ...
     0 0 0 -qd(2)  qd(1) -qd(4)  qd(3) 0 0 0 0 0 0 0; ...
     0 0 0 -qd(3)  qd(4)  qd(1) -qd(2) 0 0 0 0 0 0 0; ...
     0 0 0 -qd(4) -qd(3)  qd(2)  qd(1) 0 0 0 0 0 0 0];
 
 
% H = [1 0 0 0 0 0; ...
%      0 1 0 0 0 0; ...
%      0 0 1 0 0 0; ...
%      0 0 0 0 0 1; ...
%      0 0 0 0 0 0; ...
%      0 0 0 0 0 0];
% 
% Compute measurement noise matrix
R = diag(mNoise.^2);
%  R = diag([sigPos^2 sigPos^2 sigAng^2 sigRat^2 sigAcc^2 sigAcc^2]);    
%  
  % Solve Ricatti equations
  M = phi*Pold*phi' + Q;
  K = M*H'/(H*M*H' + R);
  Pnew = (eye(size(F)) - K*H)*M;
%  
% % Compute estimated outputs
% accMat = [0 0 0 0 0 0; ...
%           0 0 0 0 0 0; ...
%           0 0 0 0 0 0; ...
%           0 0 0 0 0 0; ...
%           1 0 0 0 0 0; ...
%           0 1 0 0 0 0];
% estOut = H*phi*inputState + H*(G.*u) + accMat*u;
estOut = H*phi*inputState;

% % Compute residuals
residual = measurements - estOut;
% 
% % Update state estimates using Kalman equation
% outputState = phi*inputState + (G.*u) + K*residual;
outputState = phi*inputState + K*residual;
