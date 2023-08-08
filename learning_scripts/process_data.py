
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
    fileDate = '2023-08-08'
    fileTime = '14-39'    # 

    scenario_type = 'eval_dv'

    file_path = os.path.dirname(sys.path[0])+"/data_storage/"+fileDate+"-"+fileTime

    episode_number = 1
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
    ref_orientation = []
    while current_time <= stop_time:
        ref_states = reference_trajectory.compute_desired_state(current_time)
        ref_position.append(ref_states[0:3])
        ref_orientation.append(ref_states[3:6])
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

    labels=['End Effector Orientation','Points','X Orientation (deg)','Y Orientation (deg)','Z Orientation (deg)']
    legend=['Acutal','Reference']
    plotData={'data0':ee['orientation']*180.0/np.pi,'data1':np.array(ref_orientation)*180.0/np.pi}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['End Effector Position Error','Points','X Position Error (m)','Y Position Error (m)','Z Position Error (m)']
    legend=['EE']
    plotData={'data0':ee['position_error']}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['End Effector Orientation Error','Points','X Orientation Error (r)','Y Orientation Error (r)','Z Orientation Error (r)']
    legend=['EE']
    plotData={'data0':ee['orientation_error']}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Arm 1 Joint Commands','Points','Joint 1 (Nm)','Joint 2 (Nm)','Joint 3 (Nm)']
    plotData={'data0':arm['jCmd']}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Arm 1 Joint Actions','Points','Joint 1 (Nm)','Joint 2 (Nm)','Joint 3 (Nm)']
    plotData={'data0':arm['action']}
    plot_static('3d',plotData,labels,legend,colors)

    labels=['Arm 1 Joint Angles','Points','Joint 1 (rad)','Joint 2 (rad)','Joint 3 (rad)']
    plotData={'data0':arm['jAngle']*rtd}
    plot_static('3d',plotData,labels,legend,colors)
    plt.show()

    return 0

if __name__ == "__main__":
    main()
