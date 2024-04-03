function [q, v, a] = compute_state_quintic(p,tVec)

    %Function to compute the object state (position,
    %velocity, acceleration) at a given time based
    %on a quintic polynomial trajectory.
    %Inputs: p - Coefficients of quintic polynomial (size 6)
    %t - time vector
    %Outputs: q - Position
    %v - Velocity
    %a - Acceleration
    
    npts = length(tVec);
    q = zeros(npts,3);
    v = zeros(npts,3);
    a = zeros(npts,3);
    
    for i=1:3
        for k=1:npts
            t = tVec(k);
            q(k,i) = p(1,i) + p(2,i)*t + p(3,i)*t^2 + p(4,i)*t^3 + p(5,i)*t^4 + p(6,i)*t^5;
            v(k,i) = p(2,i) + 2*p(3,i)*t + 3*p(4,i)*t^2 + 4*p(5,i)*t^3 + 5*p(6,i)*t^4;
            a(k,i) = 2*p(3,i) + 6*p(4,i)*t + 12*p(5,i)*t^2 + 20*p(6,i)*t^3;
        end
    
    end

end