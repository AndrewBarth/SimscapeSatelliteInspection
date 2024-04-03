function [qError] = computeErrorQuaternion2(qState,qCmd)
% Compute an error quaternion
%
% Inputs: qstate    current attitude quaternion 4x1
%         qCmd      desired attitude quaternion 4x1  
%
% Output: qError    error quaternion 4x1
%
% Assumptions and Limitations:
%    scalar is in first element of quaternion
%    
% Dependencies:
%    quatnorm
%
% References:
%    Wie, Bong. Space vehicle dynamics and control. 
%    American Institute of Aeronautics and Astronautics, 2008.
%    Section 7.3
%
% Author: Andrew Barth
%
% Modification History:
%    Jul 02 2019 - Initial version


% NEED TO RE_DERIVE THIS
qCmdtemp = [qCmd(2) qCmd(3) qCmd(4) qCmd(1)];
qStatetemp = [qState(2) qState(3) qState(4) qState(1)];

% qmat = [ qCmdtemp(4)  qCmdtemp(3) -qCmdtemp(2) -qCmdtemp(1); ...
%         -qCmdtemp(3)  qCmdtemp(4)  qCmdtemp(1) -qCmdtemp(2); ...
%          qCmdtemp(2) -qCmdtemp(1)  qCmdtemp(4) -qCmdtemp(3); ...
%          qCmdtemp(1)  qCmdtemp(2)  qCmdtemp(3)  qCmdtemp(4)];

qmat = [ qCmdtemp(4)  qCmdtemp(3) -qCmdtemp(2)  qCmdtemp(1); ...
             -qCmdtemp(3)  qCmdtemp(4)  qCmdtemp(1)  qCmdtemp(2); ...
              qCmdtemp(2) -qCmdtemp(1)  qCmdtemp(4)  qCmdtemp(3); ...
             -qCmdtemp(1) -qCmdtemp(2) -qCmdtemp(3)  qCmdtemp(4)];
     
 qErrortemp = qmat*qStatetemp';
 qErrortemp = quatnorm(qErrortemp);
 
 qError = [qErrortemp(4) qErrortemp(1) qErrortemp(2) qErrortemp(3)];