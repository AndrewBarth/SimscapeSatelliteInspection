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
