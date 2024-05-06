
function p = quintic_polynomial(ti,tf,qi,qf,vi,vf,ai,af)

    order = 5;  
    p = zeros(order+1,3);

    for i=1:3
        p(:,i) = quintic_coeffs(ti,tf,qi(i),qf(i),vi(i),vf(i),ai(i),af(i));
    end

end


function p = quintic_coeffs(t0,tf,q0,qf,v0,vf,a0,af)
  quintic_matrix = [1 t0   t0^2   t0^3    t0^4    t0^5; ...
                    0 1  2*t0   3*t0^2  4*t0^3  5*t0^4; ...
                    0 0  2      6*t0   12*t0^2 20*t0^3; ...
                    1 tf   tf^2   tf^3    tf^4    tf^5; ...
                    0 1  2*tf   3*tf^2  4*tf^3  5*tf^4; ...
                    0 0  2      6*tf   12*tf^2 20*tf^3];

  v = [q0, v0, a0, qf, vf, af];
  p = quintic_matrix\v';
end



% if dot(qi,qf) < 0
%     qf = -qf;
% end
% N = [1 0 0 0];
% Ndotf = [0 0 0 0];
% Nddotf = [0 0 0 0];
% 
% qfdot = quatmult((0.5*[0 wf] + Ndotf),qf);
% qfddot = quatmult((0.5*[0 af] + quatmult(Ndotf,[0 wf]) - 0.25*norm([0 wf])^2 + Nddotf), qf);
% 
% 
% Tvec = linspace(ti,tf);
% for k = 1:len(Tvec)
%     Tk = tf = t(k);
% 
%     Ndotk = 1/N*q
% 
% 
% function q = compute_poly(p,tau)
%    q = (1-tau)^3*(p(1) + p(2)*tau + p(3)*tau^2) + tau^3*(p(4) + p(5)*(1-tau) + p(6)*(1-tau)^2);
% end






