import os
import sys
import numpy as np
import pickle
from random import randint
import matplotlib.pyplot as plt
from utils.plot_utils import generate_trajectory_plot, plot_static, plot_xy
from utils.load_agent_data import load_data

def main():

    # Specify data
    fileDate = '2023-07-20'
    fileTime = '10-36'    

    scenario_type = 'eval_dv'

    file_path = os.path.dirname(sys.path[0])+"/data_storage/"+fileDate+"-"+fileTime

    dirlist = os.listdir(file_path)
    dirlist.sort()
    # ASSUMES all agents were run for the same number of episodes
    cases1 = [i for  i in dirlist if '1_' in i]
    episode_list = [x.replace('1_', '') for x in cases1]
    episodes = [int(x) for x in episode_list]
    episodes.sort()
 
    totalReward = []
    position_error = []
    velocity_error = []
    all_reward = []
    for episode_number in episodes:
        # Load data for this episode
        npts,sat,ee,arm,reward = load_data(str(episode_number),'1',file_path)

        # Process reward data
        cumReward = np.cumsum(reward['total_reward'],axis=0)
        totalReward.append(np.sum(cumReward[npts-1]))
        all_reward.append(reward)
 
        # Process error data
        position_error.append(ee['position_error'])
        velocity_error.append(ee['velocity_error'])


    labels=['End Effector Total Reward','Iterations','Reward']
    legend=['Arm1']
    colors=['orange','green','red','blue','cyan']
#    plotData={'data0':np.array(totalReward1),'data1':np.array(totalReward2),'data2':np.array(totalReward3)}
#    plot_static('1d',plotData,labels,legend,colors)
    xData = {}
    xData['Arm 1'] = np.array(episodes)
    yData = {}
    yData['Arm1'] = np.array(totalReward)
    plot_xy('1d',xData,yData,labels,legend,colors)

    labels=['End Effector Position Error','Points','X Error (m)','Y Error (m)','Z Error (m)']
    plotData={'data0':np.array(position_error[-1])}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['End Effector Velocity Error','Points','X Error (m/s)','Y Error (m/s)','Z Error (m/s)']
    plotData={'data0':np.array(velocity_error[-1])}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Rewards','Points','Pos Error Reward','Ori Error Reward', 'Control Reward']
    legend=['Pos Error Reward','Ori Error Reward', 'Control Reward']
    plotData={'data0':reward['poserr_reward'],'data1':reward['orierr_reward'],'data3':reward['cnterr_reward']}
    plot_static('1d',plotData,labels,legend,colors)

    plt.show()
    return

if __name__ == "__main__":
    main()
