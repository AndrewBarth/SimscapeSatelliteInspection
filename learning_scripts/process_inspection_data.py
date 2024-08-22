
import os
import sys
import numpy as np
import pickle
from random import randint
import matplotlib.pyplot as plt
from trajectory_plot import generate_trajectory_plot, plot_static, plot_xy
from utils.load_agent_data import load_data,  load_data_inspection

def main():

    #fileDate = '2023-07-17'
    #fileTime = '16-18'    # 1000 episodes varied LEO training

    fileDate = '2023-07-18'
    fileTime = '13-36'    # 1000 episodes of varied LEO evaluation

    fileDate = '2024-08-21'
    fileTime = '15-54'

    #scenario_type = 'Train'
    scenario_type = 'Eval'
    #mission = 'Transfer'
    mission = 'Inspection'


    storageLocation = '/data_storage/'

    file_path = os.path.dirname(sys.path[0])+storageLocation+fileDate+"-"+fileTime

    episode_number = 1
    nAgents = 3

    caseType='3d'

    if mission == 'Inspection':
        npts1,position1,velocity1,accel1,sim_time1,nInspected1,coverage1,reward1,orbit1,nAgents1 = load_data_inspection(str(episode_number),'1',file_path)
        cumReward1 = np.cumsum(reward1,axis=0)
        nAgents = nAgents1[0]
        if nAgents == 2:
            npts2,position2,velocity2,accel2,sim_time2,nInspected2,coverage2,reward2,orbit2,nAgents2 = load_data_inspection(str(episode_number),'2',file_path)
            cumReward2 = np.cumsum(reward2,axis=0)
        elif nAgents == 3:
            npts2,position2,velocity2,accel2,sim_time2,nInspected2,coverage2,reward2,orbit2,nAgents2 = load_data_inspection(str(episode_number),'2',file_path)
            npts3,position3,velocity3,accel3,sim_time3,nInspected3,coverage3,reward3,orbit3,nAgents3 = load_data_inspection(str(episode_number),'3',file_path)
            cumReward2 = np.cumsum(reward2,axis=0)
            cumReward3 = np.cumsum(reward3,axis=0)
        else:
            npts2,position2,velocity2,accel2,sim_time2,nInspected2,coverage2,reward2,orbit2,nAgents2 = load_data_inspection(str(episode_number),'2',file_path)
            npts3,position3,velocity3,accel3,sim_time3,nInspected3,coverage3,reward3,orbit3,nAgents3 = load_data_inspection(str(episode_number),'3',file_path)
            npts4,position4,velocity4,accel4,sim_time4,nInspected4,coverage4,reward4,orbit4,nAgents4 = load_data_inspection(str(episode_number),'4',file_path)
            cumReward2 = np.cumsum(reward2,axis=0)
            cumReward3 = np.cumsum(reward3,axis=0)
            cumReward4 = np.cumsum(reward4,axis=0)
    elif mission == 'Transfer':
        npts1,position1,velocity1,poserror1,velerror1,action1,reward1,transfer_time1,orbit1 = load_data_dv(str(episode_number),'1',file_path)
        cumReward1 = np.cumsum(reward1,axis=0)
        if nAgents == 1:
            npts2,position2,velocity2,poserror2,velerror2,action2,reward2,transfer_time2,orbit2 = load_data_dv(str(episode_number),'1',file_path)
            npts3,position3,velocity3,poserror3,velerror3,action3,reward3,transfer_time3,orbit3 = load_data_dv(str(episode_number),'1',file_path)
            npts4,position4,velocity4,poserror4,velerror4,action4,reward4,transfer_time4,orbit4 = load_data_dv(str(episode_number),'1',file_path)
            cumReward2 = np.cumsum(reward1,axis=0)
            cumReward3 = np.cumsum(reward1,axis=0)
            cumReward4 = np.cumsum(reward1,axis=0)
        elif nAgents == 2:
            npts2,position2,velocity2,poserror2,velerror2,action2,reward2,transfer_time2,orbit2 = load_data_dv(str(episode_number),'2',file_path)
            npts3,position3,velocity3,poserror3,velerror3,action3,reward3,transfer_time3,orbit3 = load_data_dv(str(episode_number),'1',file_path)
            npts4,position4,velocity4,poserror4,velerror4,action4,reward4,transfer_time4,orbit4 = load_data_dv(str(episode_number),'1',file_path)
            cumReward2 = np.cumsum(reward2,axis=0)
            cumReward3 = np.cumsum(reward1,axis=0)
            cumReward4 = np.cumsum(reward1,axis=0)
        elif nAgents == 3:
            npts2,position2,velocity2,poserror2,velerror2,action2,reward2,transfer_time2,orbit2 = load_data_dv(str(episode_number),'2',file_path)
            npts3,position3,velocity3,poserror3,velerror3,action3,reward3,transfer_time3,orbit3 = load_data_dv(str(episode_number),'3',file_path)
            npts4,position4,velocity4,poserror4,velerror4,action4,reward4,transfer_time4,orbit4 = load_data_dv(str(episode_number),'1',file_path)
            cumReward2 = np.cumsum(reward2,axis=0)
            cumReward3 = np.cumsum(reward3,axis=0)
            cumReward4 = np.cumsum(reward1,axis=0)
        else:
            npts2,position2,velocity2,poserror2,velerror2,action2,reward2,transfer_time2,orbit2 = load_data_dv(str(episode_number),'2',file_path)
            npts3,position3,velocity3,poserror3,velerror3,action3,reward3,transfer_time3,orbit3 = load_data_dv(str(episode_number),'3',file_path)
            npts4,position4,velocity4,poserror4,velerror4,action4,reward4,transfer_time4,orbit4 = load_data_dv(str(episode_number),'4',file_path)
            cumReward2 = np.cumsum(reward2,axis=0)
            cumReward3 = np.cumsum(reward3,axis=0)
            cumReward4 = np.cumsum(reward4,axis=0)


    if mission == 'Transfer':
        print('Transfer Time is: ',transfer_time1[0],' s')
        # Compute Thrust from Delta-V
        totalDeltaV1 = np.sum(np.abs(action1),axis=0)
        totalDeltaV2 = np.sum(np.abs(action2),axis=0)
        totalDeltaV3 = np.sum(np.abs(action3),axis=0)

        mass1 = 3
        mass2 = 3
        mass3 = 3
        timeStep = 0.5
    
        if scenario_type == 'Eval':
            intercept1 = int(transfer_time1[0]/timeStep)-2
            intercept2 = int(transfer_time2[0]/timeStep)-2
            intercept3 = int(transfer_time3[0]/timeStep)-2

            totalThrust1 = np.sum(np.abs(action1),axis=0) / mass1 * timeStep
            totalThrust2 = np.sum(np.abs(action2),axis=0) / mass2 * timeStep
            totalThrust3 = np.sum(np.abs(action3),axis=0) / mass3 * timeStep

            seconddv1 = velerror1[intercept1]
            seconddv2 = velerror2[intercept2]
            seconddv3 = velerror3[intercept3]

            print('Starting Position = ',position1[0])
            print('Delta-V 1 for cubesat 1 is: ',action1[0],' m/s')
            print('Delta-V 2 for cubesat 1 is: ',seconddv1,' m/s')
            print('Total Delta-V  for cubesat 1 is: ',np.linalg.norm(action1[0])+np.linalg.norm(seconddv1),' m/s')
            print('Intercept position for cubesat 1 is: ',position1[intercept1+2],' m')
            print('Final position error  for cubesat 1 = ',poserror1[npts1-1])

            print('Starting Position = ',position2[0])
            print('Delta-V 1 for cubesat 2 is: ',action2[0],' m/s')
            print('Delta-V 2 for cubesat 2 is: ',seconddv2,' m/s')
            print('Total Delta-V  for cubesat 2 is: ',np.linalg.norm(action2[0])+np.linalg.norm(seconddv2),' m/s')
            print('Intercept position for cubesat 2 is: ',position2[intercept2+2],' m')
            print('Final position error  for cubesat 2 = ',poserror2[npts2-1])

            print('Starting Position = ',position3[0])
            print('Delta-V 1 for cubesat 3 is: ',action3[0],' m/s')
            print('Delta-V 2 for cubesat 3 is: ',seconddv3,' m/s')
            print('Total Delta-V  for cubesat 3 is: ',np.linalg.norm(action3[0])+np.linalg.norm(seconddv3),' m/s')
            print('Intercept position for cubesat 3 is: ',position3[intercept3+2],' m')
            print('Final position error  for cubesat 3 = ',poserror3[npts3-1])
        if scenario_type == 'Eval':
            ref_npts1,refTrajPos1,refTrajVel1 = load_data_ref(str(episode_number),'1',file_path)
            if nAgents == 1:
                ref_npts2,refTrajPos2,refTrajVel2 = load_data_ref(str(episode_number),'1',file_path)
                ref_npts3,refTrajPos3,refTrajVel3 = load_data_ref(str(episode_number),'1',file_path)
                ref_npts4,refTrajPos4,refTrajVel4 = load_data_ref(str(episode_number),'1',file_path)
            elif nAgents == 2:
                ref_npts2,refTrajPos2,refTrajVel2 = load_data_ref(str(episode_number),'2',file_path)
                ref_npts3,refTrajPos3,refTrajVel3 = load_data_ref(str(episode_number),'1',file_path)
                ref_npts4,refTrajPos4,refTrajVel4 = load_data_ref(str(episode_number),'1',file_path)
            elif nAgents == 3:
                ref_npts2,refTrajPos2,refTrajVel2 = load_data_ref(str(episode_number),'2',file_path)
                ref_npts3,refTrajPos3,refTrajVel3 = load_data_ref(str(episode_number),'3',file_path)
                ref_npts4,refTrajPos4,refTrajVel4 = load_data_ref(str(episode_number),'1',file_path)
            else:
                ref_npts2,refTrajPos2,refTrajVel2 = load_data_ref(str(episode_number),'2',file_path)
                ref_npts3,refTrajPos3,refTrajVel3 = load_data_ref(str(episode_number),'3',file_path)
                ref_npts4,refTrajPos4,refTrajVel4 = load_data_ref(str(episode_number),'4',file_path)
        else:
            refTrajPos1 = position1 + poserror1
            refTrajPos2 = position2 + poserror2
            refTrajPos3 = position3 + poserror3
            refTrajPos4 = position4 + poserror4

        totalReward1 = np.sum(reward1,axis=1)
        totalReward2 = np.sum(reward2,axis=1)
        totalReward3 = np.sum(reward3,axis=1)
        totalReward4 = np.sum(reward4,axis=1)

        legend=['Dep 1','Dep 2','Dep 3']
        colors=['orange','green','red']
        labels=['Total Reward','Points','Reward']
        plotData={'data0':totalReward1,'data1':totalReward2,'data2':totalReward3}
        plot_static('1d',plotData,labels,legend,colors)

    legend=['Dep 1','Dep 2','Dep 3','Dep 4']
    colors=['orange','green','red','blue']
    #labels=['Cubesat Relative Position','Points','X Position (m)','Y Position (m)','Z Position (m)']
    #plotData={'data0':position1,'data1':position2,'data2':position3}
    #plot_static('3d',plotData,labels,legend,colors)

    #labels=['Cubesat Relative Velocity','Points','X Velocity (m/s)','Y Velocity (m/s)','Z Velocity (m/s)']
    #plotData={'data0':velocity1,'data1':velocity2,'data2':velocity3}
    #plot_static('3d',plotData,labels,legend,colors)

    if mission == 'Transfer':
        labels=['Cubesat Position Error','Points','X Error (m)','Y Error (m)','Z Error (m)']
        plotData={'data0':poserror1,'data1':poserror2,'data2':poserror3}
        plot_static('3d',plotData,labels,legend,colors)

        labels=['Cubesat Velocity Error','Points','X Error (m/s)','Y Error (m/s)','Z Error (m/s)']
        plotData={'data0':velerror1,'data1':velerror2,'data2':velerror3}
        plot_static('3d',plotData,labels,legend,colors)

        #labels=['Cubesat Thrust','Points','X Thrust (N)','Y Thrust (N)','Z Thrust (N)']
        #plotData={'data0':action1,'data1':action2,'data2':action3}
        #plot_static('3d',plotData,labels,legend,colors)

    if mission == 'Inspection':
        orbitData={}
        timeData={}
        nInspectedData={}
        rewardData={}
        cumRewardData={}
        positionData={}
        velocityData={}
        accelData={}
        for i in range(nAgents):
            DataKey='data'+str(i)
            orbitData[DataKey] = eval('orbit'+str(i+1)+'[:,2:5]')
            timeData[DataKey] = eval('sim_time'+str(i+1))
            nInspectedData[DataKey] = eval('nInspected'+str(i+1))
            rewardData[DataKey] = eval('reward'+str(i+1))
            cumRewardData[DataKey] = eval('cumReward'+str(i+1))
            positionData[DataKey] = eval('position'+str(i+1))
            velocityData[DataKey] = eval('velocity'+str(i+1))
            accelData[DataKey] = eval('accel'+str(i+1))
            print('Orbit Parameters for Cubesat '+str(i+1)+ ' = ',eval('orbit'+str(i+1)+'[0,0:6]'))
       
        labels=['Task Orbit','Points','Semi-Major Axis (m)','Inclination (deg)','Eccentricity (-)']
        plotData=orbitData
        plot_static('3d',plotData,labels,legend,colors)

        labels=['Inspection','Points','Inspection Time (s)']
        plotData=timeData
        plot_static('1d',plotData,labels,legend,colors)

        labels=['Inspection','Points','Faces Covered (--)']
        plotData=nInspectedData
        plot_static('1d',plotData,labels,legend,colors)

        labels=['Rewards','Points','Success Reward','Coverage Reward','Time Reward']
        plotData=rewardData
        #plot_static('4d',plotData,labels,legend,colors)
        plot_static('3d',plotData,labels,legend,colors)

        labels=['Cumulative Rewards','Points','Success Reward','Coverage Reward','Time Reward']
        plotData=cumRewardData
        plot_static('3d',plotData,labels,legend,colors)

        labels=['Cubesat Position','Points','X (m)','Y (m)','Z (m)']
        plotData=positionData
        plot_static('3d',plotData,labels,legend,colors)

        labels=['Cubesat Velocity','Points','X (m/s)','Y (m/s)','Z (m/s)']
        plotData=velocityData
        plot_static('3d',plotData,labels,legend,colors)

        labels=['Cubesat Acceleration','Points','X (m/s2)','Y (m/s2)','Z (m/s2)']
        plotData=accelData
        plot_static('3d',plotData,labels,legend,colors)

    if mission == 'Transfer':
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
