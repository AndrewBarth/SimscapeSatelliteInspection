function [poseMat] = fKinematics(DHparams,mode)
% Create a pose matrix based on a set of Denavit-Hartenberg parameters
%
% Inputs: DHparams: Set of Denavit-Hartenberg parameters (n x 4)
%                   Expected order across row: (d, a, alpha, theta)
%         mode:     Joint to compute pose for. Input as character. 
%                   Acceptable values: '1','2',...'ee','all'
%
% Output: poseMat:  Output pose matrix (n x 4 x 4)
%
% Assumptions and Limitations:
%   (none)
%
% Dependencies:
%   createDHMatrix
%   
% References:
%   Manseur, R., "Robot Modeling and Kinematics", Da Vinci Engineering Press 2006
%
% Author: Andrew Barth
%
% Modification History:
%    Oct 19 2018 - Initial version
%    Mar 15 2022 - Added array sizing for Simulink implementation
%
    nJoint = size(DHparams,1);
    A = zeros(4,4,nJoint);
    poseMat = zeros(4,4,nJoint);
    
    % Form the individual matrices
    for i=1:nJoint
        A(:,:,i) = createDHMatrix(DHparams(i,1),DHparams(i,2),DHparams(i,3),DHparams(i,4));
    end
    
    % Construct the final matrix  poseMat = A1*A2*A3*...An
    if strcmp(mode,'all')
        for i=nJoint:-1:1
            temp = squeeze(A(:,:,i));
            for j = i-1:-1:1
                temp = squeeze(A(:,:,j)) * temp;
            end
        poseMat(:,:,i) = temp;
        end
    elseif strcmp(mode,'ee')
        % Compute end effector pose (the last joint)
        temp = squeeze(A(:,:,nJoint));
        for j = i-1:-1:1
            temp = squeeze(A(:,:,j)) * temp;
        end
        poseMat = temp;
    else
        % Compute pose for the requested joint
        joint = str2num(mode);
        temp = squeeze(A(:,:,joint));
        for j = i-1:-1:1
            temp = squeeze(A(:,:,j)) * temp;
        end
        poseMat = temp;
        
end
