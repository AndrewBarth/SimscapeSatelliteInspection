
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
    time_step = 0.001

    # Specify data
    fileDate = '2023-07-12'
    fileTime = '10-59'    #
    fileDate = '2023-07-13'
    fileTime = '14-32'    #
    fileDate = '2023-07-14'
    fileTime = '08-11'    # 100 episodes of training
    fileDate = '2023-07-20'
    fileTime = '10-36'    # 

    scenario_type = 'eval_dv'

    file_path = os.path.dirname(sys.path[0])+"/data_storage/"+fileDate+"-"+fileTime

    episode_number = 100
    nAgents = 1

    caseType='3d'

    # Load data for this run
    npts,sat,ee,arm,reward = load_data(str(episode_number),'1',file_path)

    stop_time = npts*time_step

    # Create the reference trajectory
    reference_trajectory = refTraj(stop_time)
    current_time = 0
    ref_time = []
    ref_position = []
    while current_time <= stop_time:
        ref_states = reference_trajectory.compute_desired_state(current_time)
        ref_position.append(ref_states[0:3])
        current_time += time_step
        ref_time.append(current_time)

    colors=['orange','green','red']
    labels=['Servicing Satellite Position','Points','X Position (m)','Y Position (m)','Z Position (m)']
    legend=['Sat']
    plotData={'data0':sat['position']}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['End Effector Position','Points','X Position (m)','Y Position (m)','Z Position (m)']
    legend=['Acutal','Reference']
    plotData={'data0':ee['position'],'data1':np.array(ref_position)}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Arm 1 Joint Angles','Points','Joint 1 (rad)','Joint 2 (rad)','Joint 3 (rad)']
    plotData={'data0':arm['jAngle']*rtd}
    plot_static('3d',plotData,labels,legend,colors)
    plt.show()
    return

    #labels=['Cubesat Relative Velocity','Points','X Velocity (m/s)','Y Velocity (m/s)','Z Velocity (m/s)']
    #plotData={'data0':velocity1,'data1':velocity2,'data2':velocity3}
    #plot_static('3d',plotData,labels,legend,colors)

    labels=['Cubesat Position Error','Points','X Error (m)','Y Error (m)','Z Error (m)']
    plotData={'data0':poserror1,'data1':poserror2,'data2':poserror3}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Cubesat Velocity Error','Points','X Error (m/s)','Y Error (m/s)','Z Error (m/s)']
    plotData={'data0':velerror1,'data1':velerror2,'data2':velerror3}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Cubesat Thrust','Points','X Thrust (N)','Y Thrust (N)','Z Thrust (N)']
    plotData={'data0':action1,'data1':action2,'data2':action3}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Rewards','Points','Position Error Reward','Velocity Error Reward','Control Reward']
    plotData={'data0':reward1,'data1':reward2,'data2':reward3}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Cumulative Rewards','Points','Position Error Reward','Velocity Error Reward','Control Reward']
    plotData={'data0':cumReward1,'data1':cumReward2,'data2':cumReward3}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Reference Trajectory','X Position (m)', 'Y Position (m)']
    xData = {}
    xData['Dep1'] = refTrajPos1[:,0]
    xData['Dep2'] = refTrajPos2[:,0]
    xData['Dep3'] = refTrajPos3[:,0]
    yData = {}
    yData['Dep1'] = refTrajPos1[:,1]
    yData['Dep2'] = refTrajPos2[:,1]
    yData['Dep3'] = refTrajPos3[:,1]
    plot_xy('1d',xData,yData,labels,legend,colors)

    npts = position1.shape[0]
    generate_trajectory_plot(caseType,npts,position1,position2,position3,refTrajPos1,refTrajPos2,refTrajPos3)

    plt.show()
    return 0

if __name__ == "__main__":
    main()
