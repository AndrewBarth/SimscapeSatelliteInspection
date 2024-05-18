import os
import numpy as np
import pickle


def load_data(episode, agent, file_path):
    traj_file = 'agent_parameters.pkl'

    trajfile_fullpath = file_path + '/' + agent + '_' + episode + '/' + traj_file
    trajData = np.array(pickle.load(open(trajfile_fullpath, "rb")),dtype=object)

    sat = {}
    ee = {}
    arm = {}
    reward = {}
    ref = {}
    if len(trajData) > 1:
        npts = len(trajData[0])
        Data = np.array(trajData[0],dtype=object)
        sat['position']    = Data[:,0:3]
        sat['orientation'] = Data[:,3:6]
        sat['velocity']    = Data[:,6:9]
        sat['ang_rate']    = Data[:,9:12]
        ee['position']     = Data[:,12:15]
        ee['orientation']  = Data[:,15:18]
        ee['velocity']     = Data[:,18:21]
        ee['ang_rate']     = Data[:,21:24]
        arm['jAngle']      = Data[:,24:27]
        arm['jRate']       = Data[:,27:30]
        arm['jCmd']        = Data[:,30:33]
        ee['position_error']    = Data[:,33:36]
        ee['orientation_error'] = Data[:,36:39]
        ee['velocity_error']    = Data[:,39:42]
        ee['ang_rate_error']    = Data[:,42:45]
        arm['action']           = Data[:,45:48]
        reward['poserr_reward'] = Data[:,48]
        reward['orierr_reward'] = Data[:,49]
        reward['velerr_reward'] = Data[:,50]
        reward['raterr_reward'] = Data[:,51]
        reward['cnterr_reward'] = Data[:,52]
        reward['jntlmt_reward'] = Data[:,53]
        reward['smooth_reward'] = Data[:,54]
        ref['position']         = Data[:,55:58]
        ref['orientation']      = Data[:,58:61]
        ref['velocity']         = Data[:,61:64]
        ref['ang_rate']         = Data[:,64:67]
        sim_time                = Data[:,67]
        ee['sim_pos_error']     = Data[:,68:71]
        ee['sim_ori_error']     = Data[:,71:74]
        ee['sim_vel_error']     = Data[:,74:77]
        ee['sim_rat_error']     = Data[:,77:80]
        #reward['total_reward'] = reward['poserr_reward']+reward['orierr_reward']+reward['velerr_reward']+reward['raterr_reward']+reward['cnterr_reward']
        reward['total_reward'] = reward['poserr_reward']+reward['orierr_reward']+reward['cnterr_reward']+reward['jntlmt_reward']+reward['smooth_reward']
    else:
        npts = trajData.shape[1]
        sat['position']    = trajData[0,:,0:3]
        sat['orientation'] = trajData[0,:,3:6]
        sat['velocity']    = trajData[0,:,6:9]
        sat['ang_rate']    = trajData[0,:,9:12]
        ee['position']     = trajData[0,:,12:15]
        ee['orientation']  = trajData[0,:,15:18]
        ee['velocity']     = trajData[0,:,18:21]
        ee['ang_rate']     = trajData[0,:,21:24]
        arm['jAngle']      = trajData[0,:,24:27]
        arm['jRate']       = trajData[0,:,27:30]
        arm['jCmd']        = trajData[0,:,30:33]
        ee['position_error']    = trajData[0,:,33:36]
        ee['orientation_error'] = trajData[0,:,36:39]
        ee['velocity_error']    = trajData[0,:,39:42]
        ee['ang_rate_error']    = trajData[0,:,42:45]
        arm['action']           = trajData[0,:,45:48]
        reward['poserr_reward'] = trajData[0,:,48]
        reward['orierr_reward'] = trajData[0,:,49]
        reward['velerr_reward'] = trajData[0,:,50]
        reward['raterr_reward'] = trajData[0,:,51]
        reward['cnterr_reward'] = trajData[0,:,52]
        reward['jntlmt_reward'] = trajData[0,:,53]
        reward['smooth_reward'] = trajData[0,:,54]
        ref['position']         = trajData[0,:,55:58]
        ref['orientation']      = trajData[0,:,58:61]
        ref['velocity']         = trajData[0,:,61:64]
        ref['ang_rate']         = trajData[0,:,64:67]
        sim_time                = trajData[0,:,67]
        ee['sim_pos_error']     = trajData[0,:,68:71]
        ee['sim_ori_error']     = trajData[0,:,71:74]
        ee['sim_vel_error']     = trajData[0,:,74:77]
        ee['sim_rat_error']     = trajData[0,:,77:80]
        #reward['total_reward'] = reward['poserr_reward']+reward['orierr_reward']+reward['velerr_reward']+reward['raterr_reward']+reward['cnterr_reward']
        reward['total_reward'] = reward['poserr_reward']+reward['orierr_reward']+reward['cnterr_reward']+reward['jntlmt_reward']+reward['smooth_reward']

    return npts,sat,ee,arm,reward,ref,sim_time

def load_data_inspection(episode, agent, file_path):
    traj_file = 'agent_parameters.pkl'

    trajfile_fullpath = file_path + '/' + agent + '_' + episode + '/' + traj_file
    trajData_raw = np.array(pickle.load(open(trajfile_fullpath, "rb")),dtype=object)
    if trajData_raw.ndim > 2:
        trajData = np.squeeze(trajData_raw)
    else:
        trajData = trajData_raw


    npts = len(trajData)
    position       = trajData[:,0:3]
    velocity       = trajData[:,3:6]
    acceleration   = trajData[:,6:9]
    sim_time       = trajData[:,9]
    nFaces         = trajData[:,10].astype(int)
    nInspected     = trajData[:,11].astype(int)
    startIdx       = 12 
    endIdx         = 12+nFaces[-1]
    coverage       = trajData[:,startIdx:endIdx].astype(int)
#    startIdx = endIdx 
#    endIdx = endIdx+5
#    action         = trajData[:,startIdx:endIdx]
    startIdx = endIdx 
    endIdx = endIdx+3
    reward         = trajData[:,startIdx:endIdx]
    startIdx = endIdx 
    endIdx = endIdx+6
    orbit          = trajData[:,startIdx:endIdx]

    return npts,position,velocity,acceleration,sim_time,nInspected,coverage,reward,orbit

