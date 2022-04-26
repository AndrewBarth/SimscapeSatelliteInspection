function [outputState,Pnew,K] = massPropTransEKF(inputState,dt,Pold,Q,measurements,filtRotation,controlInputs,massProperties,pNoise,mNoise)
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
%         filtRotation   rotation of the principle frame
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
vb = inputState(1:3);
rb = inputState(4:6);
rd = inputState(7:9);

u = [controlInputs(1) controlInputs(2) controlInputs(3) ...
     controlInputs(1) controlInputs(2) controlInputs(3)]';

phis = pNoise;

m = massProperties(1);
J = massProperties(2);

% Rotatate measurments to principle frame
Rm = quatToDCM(filtRotation);

% Compute fundamental matrix (phi)
F = [ 0  0  0  0  0  0  0  0  0; ...
      0  0  0  0  0  0  0  0  0; ...
      0  0  0  0  0  0  0  0  0; ...
      1  0  0  0  0  0  0  0  0; ...
      0  1  0  0  0  0  0  0  0; ...
      0  0  1  0  0  0  0  0  0; ...
      0  0  0  0  0  0  0  0  0; ...
      0  0  0  0  0  0  0  0  0; ...
      0  0  0  0  0  0  0  0  0];

% Taylor series expansion
phi = eye(size(F)) + F*dt + (F*dt)^2/2;
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

H = [0  0  0  1  0  0  Rm(1,1)  Rm(1,2)  Rm(1,3);...
     0  0  0  0  1  0  Rm(2,1)  Rm(2,2)  Rm(2,3);...
     0  0  0  0  0  1  Rm(3,1)  Rm(3,2)  Rm(3,3)];
 
 
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