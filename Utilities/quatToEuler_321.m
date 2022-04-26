function [euler] = quatToEuler_321(q)
% Function to convert a set of Euler angles to a quaternion representation
%
% Inputs: q       quaternion 4x1
%
% Output: euler   Euler angles 3x1
%
% Assumptions and Limitations:
%    Euler angles expressed in radians
%    3-2-1 Euler rotation sequence
%    scalar is in first element of quaternion
%
% Dependencies:
%    quattoDCM
%    DCMToEuler_321
%
% References:
%    Kuipers, Jack B. Quaternions and rotation sequences. Vol. 66. 
%    Princeton: Princeton university press, 1999.
%
% Author: Andrew Barth
%
% Modification History:
%    May 15 2019 - Initial version
%

euler = zeros(3,1);

% mat = quatToDCM(q);
% 
% euler = DCMToEuler_321(mat);
sin_theta = -2.0 * (q(2) * q(4) + q(1) * q(3));


%  Protect for sin_theta out of limits
if (sin_theta > 1.0 )
    sin_theta = 1.0;
elseif (sin_theta < -1.0)
    sin_theta = -1.0;
end
cos_theta = sqrt(1.0 - sin_theta*sin_theta);

cPsR =   2.0 * (q(3) * q(4) - q(1) * q(2));
cPcR =   2.0 * (q(1) * q(1) + q(4) * q(4)) - 1.0;
cP = sqrt(cPsR*cPsR + cPcR*cPcR);

% euler(2) = asin(sin_theta);
euler(2) = atan2(sin_theta,cP);

if(cos_theta >= 4.8281e-04)
        euler(1) = atan2( 2.0 * (q(3) * q(4) - q(1) * q(2)) , 1.0 - 2.0 * (q(2) * q(2) + q(3) * q(3)));
        euler(3) = atan2( 2.0 * (q(2) * q(3) - q(1) * q(4)) , 1.0 - 2.0 * (q(3) * q(3) + q(4) * q(4)));
else
        euler(1) = 0.0;
        euler(3) = atan2( (2.0 * (q(2)*q(3) - q(1)*q(4))) , (1.0 - 2.0 * (q(2)*q(2) + q(4)*q(4))));
end


