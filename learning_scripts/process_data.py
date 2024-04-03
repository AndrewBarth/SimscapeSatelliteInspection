
import os
import sys
import numpy as np
import pickle
from random import randint
import matplotlib.pyplot as plt
from utils.plot_utils import generate_trajectory_plot, plot_static, plot_xy
from utils.load_agent_data import load_data
from reference_trajectory import refTraj

def main():

    rtd = 180/np.pi
    #time_step = 0.001
    time_step = 0.01

    # Specify data
    fileDate = '2024-03-26'
    fileTime = '13-31'

    scenario_type = 'eval_dv'

    file_path = os.path.dirname(sys.path[0])+"/data_storage/"+fileDate+"-"+fileTime

    episode_number = 1
    nAgents = 1

    caseType='3d'

    # Load data for this run
    npts,sat,ee,arm,reward,ref,sim_time = load_data(str(episode_number),'1',file_path)

    stop_time = npts*time_step

    # Process reward data
    totalReward = []
    all_reward = []
    cumReward = np.cumsum(reward['total_reward'],axis=0)
    cumPosReward = np.cumsum(reward['poserr_reward'],axis=0)
    cumOriReward = np.cumsum(reward['orierr_reward'],axis=0)
    cumCntReward = np.cumsum(reward['cnterr_reward'],axis=0)
    cumJntReward = np.cumsum(reward['jntlmt_reward'],axis=0)
    cumSmoReward = np.cumsum(reward['smooth_reward'],axis=0)
    totalReward.append(np.sum(cumReward[npts-1]))
    all_reward.append(reward)

    # Create the reference trajectory
    reference_trajectory = refTraj(stop_time)
    current_time = 0
    ref_time = []
    ref_position = []
    ref_orientation = []
    while current_time <= stop_time:
        ref_states = reference_trajectory.compute_desired_state(current_time)
        ref_position.append(ref_states[0:3])
        ref_orientation.append(ref_states[3:6])
        current_time += time_step
        ref_time.append(current_time)

    colors=['orange','green','red','blue','cyan','olive']
    #labels=['Servicing Satellite Position','Points','X Position (m)','Y Position (m)','Z Position (m)']
    #legend=['Sat']
    #plotData={'data0':sat['position']}
    #plot_static('3d',plotData,labels,legend,colors)

    labels=['End Effector Position','Points','X Position (m)','Y Position (m)','Z Position (m)']
    legend=['Actual','Reference']
    #plotData={'data0':ee['position'],'data1':np.array(ref_position)}
    plotData={'data0':ee['position'],'data1':ref['position']}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['End Effector Orientation','Points','X Orientation (deg)','Y Orientation (deg)','Z Orientation (deg)']
    legend=['Actual','Reference']
    #plotData={'data0':ee['orientation']*rtd,'data1':np.array(ref_orientation)*rtd}
    plotData={'data0':ee['orientation']*rtd,'data1':ref['orientation']*rtd}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['End Effector Angular Rates','Points','X Rate (deg/s)','Y Rate (deg/s)','Z Rate (deg/s)']
    legend=['Actual']
    plotData={'data0':ee['ang_rate']}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['End Effector Position Error','Points','X Position Error (m)','Y Position Error (m)','Z Position Error (m)']
    legend=['EE','Sim']
    plotData={'data0':ee['position_error'],'data1':ee['sim_pos_error']}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['End Effector Orientation Error','Points','X Orientation Error (deg)','Y Orientation Error (deg)','Z Orientation Error (deg)']
    legend=['EE','Sim']
    plotData={'data0':ee['orientation_error']*rtd,'data1':ee['sim_ori_error']*rtd}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Arm 1 Joint Commands','Points','Joint 1 (Nm)','Joint 2 (Nm)','Joint 3 (Nm)']
    plotData={'data0':arm['jCmd']}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Arm 1 Joint Actions','Points','Joint 1 (Nm)','Joint 2 (Nm)','Joint 3 (Nm)']
    plotData={'data0':arm['action']}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Arm 1 Joint Angles','Points','Joint 1 (deg)','Joint 2 (deg)','Joint 3 (deg)']
    plotData={'data0':arm['jAngle']*rtd}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Arm 1 Joint Rates','Points','Joint 1 (d/s)','Joint 2 (d/s)','Joint 3 (d/s)']
    plotData={'data0':arm['jRate']*rtd}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Rewards','Points','Pos Error Reward','Ori Error Reward', 'Control Reward', 'Joint Limit Reward']
    legend=['Pos Error Reward','Ori Error Reward', 'Control Reward', 'Joint Limit Reward']
    plotData={'data0':reward['poserr_reward'],'data1':reward['orierr_reward'],'data3':reward['cnterr_reward'],'data4':reward['jntlmt_reward']}
    plot_static('1d',plotData,labels,legend,colors)

    labels=['Cumulative Rewards','Points','Pos Error Reward','Ori Error Reward', 'Control Reward', 'Joint Limit Reward', 'Total Reward']
    legend=['Pos Error Reward','Ori Error Reward', 'Control Reward', 'Joint Limit Reward', 'Smoothness Reward', 'Total Reward']
    plotData={'data0':cumPosReward,'data1':cumOriReward,'data2':cumCntReward,'data3':cumJntReward,'data4':cumSmoReward,'data5':cumReward}
    plot_static('1d',plotData,labels,legend,colors)

    labels=['Sim Time','Points','Time (s)']
    plotData={'data0':sim_time}
    plot_static('1d',plotData,labels,legend,colors)

    plt.show()

    return 0

if __name__ == "__main__":
    main()
