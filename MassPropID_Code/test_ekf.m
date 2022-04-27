
addpath('../utilities')


% Parameter settings from reference
sigTheta = 3.4e-2;
supw = 0.06;
vmax = 0.5;
deltaRmax = 2;
sigmaR = 0.02;

% Load observed position and orientation data
load obsData.mat
observedQuat = client_gc.rotation.quat.Data;
observedPos  = client_gc.translation.position.Data;
sensedForce = rod_ft.Data(:,1:3);
sensedMoment = rod_ft.Data(:,4:6);
sensorPos = ft_sensor.translation.position.Data;

% Assumes all data recording from the simulation is at the same rate
timeVec = client_gc.rotation.quat.Time;

nPts = size(observedQuat,1);



% Set initial state estimate
clear rotState transState newRotState newTransState
rotState(1,:) = [0 0 0 1 0 0 0 1/sqrt(3) 1/sqrt(3) 1/sqrt(3) 1 0 0 0];
transState(1,:) = [0 0 0 observedPos(1,:) 0 0 0];



% Intial Covariance Estimates
fSampEst = 100;   % Hz
c = sqrt(supw / (2*pi* fSampEst));
rotP = diag(c*[supw/c supw/c supw/c 1 1 1 1 1/sqrt(3) 1/sqrt(3) 1/sqrt(3) 1 1 1 1]).^2;
rotQ = 1e-4*rotP;

transP = diag([vmax vmax vmax deltaRmax deltaRmax deltaRmax deltaRmax deltaRmax deltaRmax]).^2;
transQ = 1e-6*transP;

% Leftover variables, process noise is included in Q from above
rotpNoise = 0;
transpNoise = 0;

% Measurement noise estimates (will be squared inside ekf)
rotmNoise = [sigTheta/2 sigTheta/2 sigTheta/2 sigTheta/2];
transmNoise = [sigmaR sigmaR sigmaR];

% Find first contact
contactMade = 0;
inContact = 0;
firstContactIdx=find(vecnorm(sensedForce,2,2)>0.1,1);

dt(1) = 0;

estDeltaJ = [0 0 0];
estDeltaL = [0 0 0];


for k = 1:nPts
    
    if k > 1
        dt(k) = timeVec(k) - timeVec(k-1);
    end

    rotMeasurements = observedQuat(k,:);
    posMeasurements = observedPos(k,:);
    
    controlInputs = [0 0 0];
    massProperties = [10 1];

    % Call rotational EKF
    [newRotState,newRotP,rotK] = massPropRotEKF(rotState(k,:)',dt(k),rotP,rotQ,rotMeasurements',controlInputs,massProperties,rotpNoise,rotmNoise);
    rotState(k+1,:) = newRotState';
    
    % Call translational EKF (dependency on output of rotational EKF)
    filtRotation = rotState(k,4:7)';
    filtT = quatToDCM(filtRotation);
    
    [newTransState,newTransP,transK] = massPropTransEKF(transState(k,:)',dt(k),transP,transQ,posMeasurements',filtRotation,controlInputs,massProperties,transpNoise,transmNoise);
    transState(k+1,:) = newTransState';


    % Gradually reduce process noise
    gamma = 0.995;
    a(k) = 0.999*gamma^2 + 0.001;
    rotQ = a(k)*rotQ;
    transQ = a(k)*transQ;

    % Check to see if contact has been made
    if k > firstContactIdx && contactMade == 0
        % Snap the state one timestep prior to first contact
        preContactRotState = rotState(k-1,:);
        preContactTransState = transState(k-1,:);
        
        preContactSigmaP = diag(rotState(k-1,1:3));
        preContactInertiaBar = rotState(k-1,8:10)';
        preContactFiltT = quatToDCM(rotState(k-1,4:7)');
 
        fprintf('First Contact at: %6.2f seconds\n',timeVec(k))
        contactMade = 1;
        inContact = 1;
        
    end
    
    % Accumulate linear and angular momentum during contact
    if inContact == 1  
        if vecnorm(sensedForce(k,:),2,2) > 0.1
            ros = sensorPos(k,:);
            estDeltaJ = estDeltaJ - sensedForce(k,:)*dt(k);
            estDeltaL = estDeltaL - (cross(ros,sensedForce(k,:)) + sensedMoment(k,:))*dt(k);
        else
            % Contact period is over
            inContact = 0;
        end
    end
    
    if contactMade == 1
        % Compute the estimated mass
        estDeltaV = transState(k,1:3) - preContactTransState(1:3);
        estMass(k) = (estDeltaV*estDeltaJ') / (estDeltaV*estDeltaV');
        
        sigmaP = diag(rotState(k,1:3));
        inertiaBar = rotState(k,8:10)';
        
        deltaLrotate = estDeltaL - cross(estMass(k)*transState(k,4:6), transState(k,1:3));
        estDeltaH = filtT*sigmaP*inertiaBar - preContactFiltT*preContactSigmaP*preContactInertiaBar;
        estK = (estDeltaH'*deltaLrotate') / (estDeltaH'*estDeltaH);
        estInertia(k,:) = (estK*inertiaBar)';
    else
        estMass(k) = 0;
        estInertia(k,:) = zeros(1,3);
    end
    
end