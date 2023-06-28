
import os
import sys
import numpy as np
import pickle
from random import randint
import matplotlib.pyplot as plt
import matplotlib.patches as patches
import matplotlib.transforms as transforms
from matplotlib.animation import FuncAnimation
import matplotlib.animation as animation
from mpl_toolkits.mplot3d import Axes3D
from scipy.spatial.transform import Rotation


def generate_trajectory_plot(caseType,npts,position1,position2,position3,refTraj1,refTraj2,refTraj3):

    def animate(i,xs1:list,ys1:list,zs1:list,
                  xs2:list,ys2:list,zs2:list,xs3:list,ys3:list,zs3:list,
                  xe1:list,ye1:list,ze1:list,xe2:list,ye2:list,ze2:list,
                  xe3:list,ye3:list,ze3:list,fovs:list,origin:list,
                  labels,legend,caseType):
        xs1.append(sampledposition1[i,0])
        ys1.append(sampledposition1[i,1])
        zs1.append(sampledposition1[i,2])
        xs2.append(sampledposition2[i,0])
        ys2.append(sampledposition2[i,1])
        zs2.append(sampledposition2[i,2])
        xs3.append(sampledposition3[i,0])
        ys3.append(sampledposition3[i,1])
        zs3.append(sampledposition3[i,2])
        xe1.append(sampledrefTraj1[i,0])
        ye1.append(sampledrefTraj1[i,1])
        ze1.append(sampledrefTraj1[i,2])
        xe2.append(sampledrefTraj2[i,0])
        ye2.append(sampledrefTraj2[i,1])
        ze2.append(sampledrefTraj2[i,2])
        xe3.append(sampledrefTraj3[i,0])
        ye3.append(sampledrefTraj3[i,1])
        ze3.append(sampledrefTraj3[i,2])
        origin.append(0.0)
        
        maxValX=np.max(np.abs([sampledposition1[:,0],sampledposition2[:,0],sampledposition3[:,0]]))
        maxValY=np.max(np.abs([sampledposition1[:,1],sampledposition2[:,1],sampledposition3[:,1]]))
        maxValZ=np.max(np.abs([sampledposition1[:,2],sampledposition2[:,2],sampledposition3[:,2]]))
        maxVal = np.max([maxValX,maxValY,maxValZ])
        #rotangle=2*np.arctan2(sampledquaternion0[i,2],sampledquaternion0[i,3])*180/np.pi
        rotangle=0.0
        chief_color = 'black'
        ax.clear()
        ax.set_xlim(-maxVal*1.1,maxVal*1.1)
        ax.set_ylim(-maxVal*1.1,maxVal*1.1)
        if caseType == '3d':
            ax.set_zlim(-maxVal*1.1,maxVal*1.1)

        trans = transforms.blended_transform_factory(ax.transData, ax.transAxes)
        rect = patches.Rectangle((0, 0), width=40, height=20, 
                          color=chief_color,alpha=0.5,angle=rotangle,label=legend[0])
        if caseType == '2d':
#            ax.add_patch(rect)
            ax.plot(xs1,ys1,label=legend[0],color='orange')
            ax.plot(xs2,ys2,label=legend[1],color='green')
            ax.plot(xs3,ys3,label=legend[2],color='red')
            ax.plot(xe1,ye1,label='ref',linestyle='--',color='orange')
            ax.plot(xe2,ye2,label='ref',linestyle='--',color='green')
            ax.plot(xe3,ye3,label='ref',linestyle='--',color='red')
            ax.plot(0,0,'k*')
            ax.set_aspect('equal')          
        else:

            #x, y, z = np.indices((40, 20, 20))
            #cube1 = (x < 40) & (y < 20) & (z < 20)
            #ax.voxels(cube1)
            ax.plot(xs1,ys1,zs1,label=legend[0],color='orange')
            ax.plot(xs2,ys2,zs2,label=legend[1],color='green')
            ax.plot(xs3,ys3,zs3,label=legend[2],color='red')
            ax.plot(xe1,ye1,ze1,label='ref',linestyle='--',color='orange')
            ax.plot(xe2,ye2,ze2,label='ref',linestyle='--',color='green')
            ax.plot(xe3,ye3,ze3,label='ref',linestyle='--',color='red')
            #ax.plot([origin,xbore],[origin,ybore],[origin,zbore],color='blue')
            ax.set_zlabel(labels[3])
        ax.set_title(labels[0])
        ax.set_xlabel(labels[1])
        ax.set_ylabel(labels[2])
 
        ax.legend(loc='upper left')



    animatedPlot = 1
    #fig, ax = plt.subplots()
    fig = plt.figure()
    if caseType=='3d':
        ax = fig.add_subplot(projection='3d')
    else:
        ax = fig.add_subplot()

    xs1,ys1,zs1,xs2,ys2,zs2,xs3,ys3,zs3,xe1,ye1,ze1,xe2,ye2,ze2,xe3,ye3,ze3,origin=([] for i in range(19))
    fovs=[]
 
    labels=['Trajectory of Satellites','X Position (m)','Y Position (m)','Z Position (m)']
    legend=['Dep1','Dep2','Dep3']
    if (animatedPlot ==1):
        # Need to downsample data to improve speed of animation
        step=10
        sampledposition1 = position1[0::step,:]
        sampledposition2 = position2[0::step,:]
        sampledposition3 = position3[0::step,:]
        sampledrefTraj1 = refTraj1[0::step,:]
        sampledrefTraj2 = refTraj2[0::step,:]
        sampledrefTraj3 = refTraj3[0::step,:]

        ani = FuncAnimation(fig, animate, fargs=(xs1,ys1,zs1,xs2,ys2,zs2,
                                                 xs3,ys3,zs3,xe1,ye1,ze1,xe2,ye2,ze2,
                                                 xe3,ye3,ze3,fovs,origin,
                                                 labels,legend,caseType), frames=int(npts/step), interval=1, repeat=False )

        # Save animation to gif
        #f = r"./animation.gif" 
        #writergif = animation.PillowWriter(fps=30) 
        #ani.save(f, writer=writergif)

    else:
        ax.clear()
        trans = transforms.blended_transform_factory(ax.transData, ax.transAxes)
        
        rect = patches.Rectangle((0, 0), width=20, height=10, 
                          color='red', alpha=0.5,label=legend[0])
        ax.add_patch(rect)
        ax.plot(position1[:,0],position1[:,1],label=legend[0])
        ax.plot(position2[:,0],position2[:,1],label=legend[1])
        ax.plot(position3[:,0],position3[:,1],label=legend[2])
        ax.set_title(labels[0])
        ax.set_xlabel(labels[1])
        ax.set_ylabel(labels[2])
        handles, labels = ax.get_legend_handles_labels()
        # sort both labels and handles by labels
        labels, handles = zip(*sorted(zip(labels, handles), key=lambda t: t[0]))
        ax.legend(handles, labels)

    plt.show()

def plot_static(mode,plotData,labels,legend,colors):
    npts=[]
    *keys, = plotData
    if mode == '1d':
        fig, ax1 = plt.subplots() 
    elif mode == '2d':
        fig, (ax1,ax2) = plt.subplots(2,1)
    else:
        fig, (ax1,ax2,ax3) = plt.subplots(3,1)

    nPlots = len(plotData)
    ax1.clear()
   
    for i in range(nPlots):
        npts.append(plotData[keys[i]].shape[0])
        if mode == '1d':
            ax1.plot(range(npts[i]),plotData[keys[i]],color=colors[i],label=legend[i])
        else:
            ax1.plot(range(npts[i]),plotData[keys[i]][:,0],color=colors[i],label=legend[i])
    ax1.set_title(labels[0])
    ax1.set_xlabel(labels[1])
    ax1.set_ylabel(labels[2])
    ax1.legend()
    #ax1.legend(loc='upper right')

    if mode == '2d' or mode == '3d':
        ax2.clear()
        for i in range(nPlots):
            ax2.plot(range(npts[i]),plotData[keys[i]][:,1],color=colors[i],label=legend[i])
        ax2.set_xlabel(labels[1])
        ax2.set_ylabel(labels[3])
        ax2.legend()
        #ax2.legend(loc='upper right')

    if mode == '3d':
        ax3.clear()
        for i in range(nPlots):
            ax3.plot(range(npts[i]),plotData[keys[i]][:,2],color=colors[i],label=legend[i])
        ax3.set_xlabel(labels[1])
        ax3.set_ylabel(labels[4])
        ax3.legend()
        #ax3.legend(loc='upper right')

def plot_xy(mode,xData,yData,labels,legend,colors):
    npts=[]
    *xkeys, = xData
    *ykeys, = yData
    if mode == '1d':
        fig, ax1 = plt.subplots() 
    elif mode == '2d':
        fig, (ax1,ax2) = plt.subplots(2,1)
    else:
        fig, (ax1,ax2,ax3) = plt.subplots(3,1)

    nPlots = len(yData)
    ax1.clear()
   
    for i in range(nPlots):

        if mode == '1d':
            ax1.plot(xData[xkeys[i]],yData[ykeys[i]],color=colors[i],label=legend[i])
        else:
            ax1.plot(xData[xkeys[i]][:,0],yData[ykeys[i]][:,0],color=colors[i],label=legend[i])
    ax1.set_title(labels[0])
    ax1.set_xlabel(labels[1])
    ax1.set_ylabel(labels[2])
    ax1.legend()

    if mode == '2d' or mode == '3d':
        ax2.clear()
        for i in range(nPlots):
            ax2.plot(xData[xkeys[i]][:,1],yData[ykeys[i]][:,1],color=colors[i],label=legend[i])
        ax2.set_xlabel(labels[1])
        ax2.set_ylabel(labels[3])
        ax2.legend()

    if mode == '3d':
        ax3.clear()
        for i in range(nPlots):
            ax3.plot(xData[xkeys[i]][:,2],yData[ykeys[i]][:,2],color=colors[i],label=legend[i])
        ax3.set_xlabel(labels[1])
        ax3.set_ylabel(labels[4])
        ax3.legend()

def midpoints(x):
    sl = ()
    for i in range(x.ndim):
        x = (x[sl + np.index_exp[:-1]] + x[sl + np.index_exp[1:]]) / 2.0
        sl += np.index_exp[:]
    return x
