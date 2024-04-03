import os
import numpy as np

def EulerToQuat_321(euler):
    """
     Function to convert a set of Euler angles to a quaternion representation
    
     Inputs: euler   Euler angles 3x1
    
     Output: q       quaternion 4x1
    
     Assumptions and Limitations:
        Euler angles expressed in radians
        3-2-1 Euler rotation sequence
        scalar is in first element of quaternion
    
     Dependencies:
        quatmult
    
     References:
        Kuipers, Jack B. Quaternions and rotation sequences. Vol. 66. 
        Princeton: Princeton university press, 1999.
    
        Wie, Bong. Space vehicle dynamics and control. 
        American Institute of Aeronautics and Astronautics, 2008.
    
     Author: Andrew Barth
    
     Modification History:
        May 15 2019 - Initial version
        Sep 23 2022 - Default sizing added for Simulink
    
    """
    # Compute component quaternions
    q3 = np.array([np.cos(euler[2]/2), 0, 0, np.sin(euler[2]/2)])
    q2 = np.array([np.cos(euler[1]/2), 0, np.sin(euler[1]/2), 0])
    q1 = np.array([np.cos(euler[0]/2), np.sin(euler[0]/2), 0, 0])

    # Compute output q = q3*q2*q1
    q21  = quatmult(q2,q1)
    q321 = quatmult(q3,q21)
    q = q321
    return q

def quatConj(qin):
    '''
    Function to form the conjucate of a quaternion
    
    Inputs: qin     input quaternion 4x1
    
    Output: qout    output quaternion 4x1
   
    Assumptions and Limitations:
       scalar is in first element of quaternion
    
    Dependencies:
    
    References:
       Kuipers, Jack B. Quaternions and rotation sequences. Vol. 66. 
       Princeton: Princeton university press, 1999.
    
    Author: Andrew Barth
    
    Modification History:
       May 16 2019 - Initial version
    ''' 

    qout = np.append(qin[0],-1*qin[1:4])

    return qout

def quatnorm(qin):
    '''
    % Function to normalize a quaternion
    %
    % Inputs: qin       input quaternion 4x1
    %
    % Output: qout      output quaternion 4x1
    %
    % Assumptions and Limitations:
    %    scalar is in first element of quaternion
    %
    % Dependencies:
    %
    % References:
    %    Kuipers, Jack B. Quaternions and rotation sequences. Vol. 66. 
    %    Princeton: Princeton university press, 1999.
    %
    % Author: Andrew Barth
    %
    % Modification History:
    %    Jun 30 2019 - Initial version
    %
    '''

    qnorm = np.sqrt(qin[0]**2 + qin[1]**2 + qin[2]**2 + qin[3]**2)

    qout = qin/qnorm
    return qout

def quatmult(q1,q2):
    """
     Function to multiply two quaternions
    
     Inputs: q1      first input quaternion 1x4
             q2      second input quaternion 1x4
     
     Output: q       output quaternion 1/4
    
     Assumptions and Limitations:
        scalar is in first element of quaternion
    
     Dependencies:
    
     References:
        Kuipers, Jack B. Quaternions and rotation sequences. Vol. 66. 
        Princeton: Princeton university press, 1999.
    
     Author: Andrew Barth
    
     Modification History:
        May 16 2019 - Initial version
    
    """

    # Form alias
    q1s = q1[0]
    q1v = q1[1:4]
    q2s = q2[0]
    q2v = q2[1:4]

    # Compute multiplication
    qs = q1s*q2s -1*np.dot(q1v,q2v)
    qv = q1s*q2v + q2s*q1v + np.cross(q1v,q2v)

    # Form output
    q = np.append(qs, qv)

    return q

def quatrotate(vin,q):
    '''
     Function to perform a frame rotation on a vector using a quaternion

     Inputs: vin     input vector in frame A 3x1
             q       quaternion rotation from A to B
 
     Output: vout    output vector in frame B 3x1
    
     Assumptions and Limitations:
        scalar is in first element of quaternion

     Dependencies:
        quatmult
        quatconj

     References:
        Kuipers, Jack B. Quaternions and rotation sequences. Vol. 66. 
        Princeton: Princeton university press, 1999.

     Author: Andrew Barth

     Modification History:
        May 16 2019 - Initial version

    '''

    # Add a zero scalar term to the input vector
    qv = np.append(0,vin)

    # Get the quaternion conjugate
    qconj = quatConj(q)

    # Perform quaternion rotations

    temp = quatmult(qconj,qv)
    temp1 = quatmult(temp,q)
    vout = temp1[1:4]

    return vout

def computeErrorQuaternion(qState,qCmd):
    '''
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
    '''


    #% NEED TO RE_DERIVE THIS
    qCmdtemp = np.array([qCmd[1], qCmd[2], qCmd[3], qCmd[0]])
    qStatetemp = np.array([qState[1], qState[2], qState[3], qState[0]])

    qmat = [ [ qCmdtemp[3],  qCmdtemp[2], -qCmdtemp[1],  qCmdtemp[0]], \
             [-qCmdtemp[2],  qCmdtemp[3],  qCmdtemp[0],  qCmdtemp[1]], \
             [ qCmdtemp[1], -qCmdtemp[0],  qCmdtemp[3],  qCmdtemp[2]], \
             [-qCmdtemp[0], -qCmdtemp[1], -qCmdtemp[2],  qCmdtemp[3]]]
     
    qErrortemp = np.dot(qmat,qStatetemp.T)
    qErrortemp = quatnorm(qErrortemp)
 
    qError = np.array([qErrortemp[3], qErrortemp[0], qErrortemp[1], qErrortemp[2]])
 
    return qError

def quatToMRP(q):
    '''
    Function to convert a quaternion to a Modified Rodrigues Parameter representation
   
    Inputs: q       quaternion 4x1
  
    Output: mrp     modified rodrigues parameters 3x1
   
    Assumptions and Limitations:
       scalar is in first element of quaternion
   
    Dependencies:
   
    References:
       Kuipers, Jack B. Quaternions and rotation sequences. Vol. 66. 
       Princeton: Princeton university press, 1999.
   
    Author: Andrew Barth
   
    Modification History:
       Aug 08 2023 - Initial version
    '''

    mrp = np.append(q[1]/(1+q[0]), (q[2]/(1+q[0]), q[3]/(1+q[0])))

    #s = np.dot(mrp.T,mrp)
    #if s > 0.98 and s < 1.02:
    #    mrp = -mrp/s

    return mrp

def MRPToQuat(mrp):
    '''
    Function to convert a Modified Rodrigues Parameter representation to a quaternion
   
    Input: mrp     modified rodrigues parameters 3x1

    Output: q      quaternion 4x1
   
    Assumptions and Limitations:
       scalar is in first element of quaternion
   
    Dependencies:
   
    References:
       Kuipers, Jack B. Quaternions and rotation sequences. Vol. 66. 
       Princeton: Princeton university press, 1999.
   
    Author: Andrew Barth
   
    Modification History:
       Aug 08 2023 - Initial version
    '''

    magsq = np.dot(mrp,mrp)
    q = np.append((1 - magsq), 2*mrp[0:3]) / (1 + magsq)

    return q

def quatToEuler_321(q):
    '''
    Function to convert a quaternion to a set of Euler angles
    
    Inputs: q       quaternion 4x1
    
    Output: euler   Euler angles 3x1
    
    Assumptions and Limitations:
       Euler angles expressed in radians
       3-2-1 Euler rotation sequence
       scalar is in first element of quaternion
    
    Dependencies:
       quattoDCM
       DCMToEuler_321
    
    References:
       Kuipers, Jack B. Quaternions and rotation sequences. Vol. 66. 
       Princeton: Princeton university press, 1999.
    
    Author: Andrew Barth
    
    Modification History:
       May 15 2019 - Initial version
    '''

    euler = np.zeros(3)

    sin_theta = -2.0 * (q[1] * q[3] + q[0] * q[2])

    # Protect for sin_theta out of limits
    if sin_theta > 1.0:
        sin_theta = 1.0
    elif sin_theta < -1.0:
        sin_theta = -1.0

    cos_theta = np.sqrt(1.0 - sin_theta*sin_theta);

    cPsR =   2.0 * (q[2] * q[3] - q[0] * q[1])
    cPcR =   2.0 * (q[0] * q[0] + q[3] * q[3]) - 1.0
    cP = np.sqrt(cPsR*cPsR + cPcR*cPcR)

    euler[1] = np.arctan2(sin_theta,cP)

    if cos_theta >= 4.8281e-04:
        euler[0] = np.arctan2( 2.0 * (q[2] * q[3] - q[0] * q[1]) , 1.0 - 2.0 * (q[1] * q[1] + q[2] * q[2]));
        euler[2] = np.arctan2( 2.0 * (q[1] * q[2] - q[0] * q[3]) , 1.0 - 2.0 * (q[2] * q[2] + q[3] * q[3]));
    else:
        euler[0] = 0.0;
        euler[2] = np.arctan2( (2.0 * (q[1]*q[2] - q[0]*q[3])) , (1.0 - 2.0 * (q[1]*q[1] + q[3]*q[3])));

    return euler

def MRPError(MRPState,MRPCmd):
    '''
    Compute the error between two sets of Modified Rodrigues Parameters

    Args:
        MRPState: MRP representing the current state
        MRPCmd: MRP representing the commanded state

    Reference:  Shuster, Malcolm D. "A survey of attitude representations." Navigation 8, no. 9 (1993): 439-517.

    Error formed by MRP composition operator Ref. 1, Eq. 257 
    Cmd comp State
    '''
    MRPError = np.zeros(3)

    # Compute the square of the norm for each MRP
    normSqrdState = np.linalg.norm(MRPState)**2
    normSqrdCmd = np.linalg.norm(MRPCmd)**2

    # Compute MRP error
    num = (1 - normSqrdState)*MRPCmd - (1 - normSqrdCmd)*MRPState - 2*np.matmul(skewMat(MRPCmd),MRPState)
    den = 1 + normSqrdCmd*normSqrdState - 2*np.matmul(MRPCmd,MRPState)

    MRPError = num/den

    if np.linalg.norm(MRPState) > 1e-3:
        # Compute error using shadow set of MRP
        MRPStateS = -MRPState / (np.dot(MRPState.T,MRPState))
        normSqrdStateS = np.linalg.norm(MRPStateS)**2
        numS = (1 - normSqrdStateS)*MRPCmd - (1 - normSqrdCmd)*MRPStateS - 2*np.matmul(skewMat(MRPCmd),MRPStateS)
        denS = 1 + normSqrdCmd*normSqrdStateS - 2*np.matmul(MRPCmd,MRPStateS)
        MRPErrorS = numS/denS

        # Use the smallest error value between the originial MPR and shadow set 
        if np.linalg.norm(MRPErrorS) < np.linalg.norm(MRPError):
            MRPError = MRPErrorS

    #s = np.dot(MRPError.T,MRPError)
    #if s > 0.98 and s < 1.02:
    #    MRPError = -MRPError/s

    MRPError = MRPCmd - MRPState

    if np.linalg.norm(MRPCmd) > 1/3:
        # Compute error using shadow set of MRP
        MRPCmdS = -MRPCmd / (np.dot(MRPCmd,MRPCmd))
        MRPErrorS = MRPCmdS - MRPState

        # Use the smallest error value between the originial MPR and shadow set
        if np.linalg.norm(MRPErrorS) < np.linalg.norm(MRPError):
            MRPError = MRPErrorS

    return MRPError

def skewMat(vec):
    '''
    Compose a skew matrix given a vector
    
    Inputs: vec (3x1)
    
    Output: mat (3x3)
    
    Assumptions and Limitations:
      (none)

    References:
      (none)

    Author: Andrew Barth
    
    Modification History:
       Mar 21 2019 - Initial version
    
    '''
    mat = np.array([[0, -vec[2], vec[1]],[vec[2], 0, -vec[0]],[-vec[1], vec[0], 0]])
    return mat

def save_csv(content, fdir, fname):
    """
    Save content into path/name as csv file
    Args:
        content: to be saved, dict
        path: file path, str
        fname: file name, str
    """
    # Make directory if it does not already exist
    if not os.path.exists(fdir):
        os.makedirs(fdir)

    file_path = os.path.join(fdir, fname)
    with open(file_path, 'w') as f:
        for key in content.keys():
            f.write("{},{}\n".format(key,content[key]))

def save_mat(content, fdir, fname):
    """
    Save content into path/name as mat file
    Args:
        content: to be saved, dict
        path: file path, str
        fname: file name, str
    """
    # Make directory if it does not already exist
    if not os.path.exists(fdir):
        os.makedirs(fdir)

    file_path = os.path.join(fdir, fname)
    with open(file_path, 'w') as f:
        savemat(file_path, content) 
