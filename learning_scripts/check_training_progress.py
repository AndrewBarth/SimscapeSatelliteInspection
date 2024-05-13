
import os
import sys
import time
import pickle
import csv
import json
import numpy as np
import ray
from datetime import datetime
import matplotlib.pyplot as plt
from trajectory_plot import generate_trajectory_plot, plot_static, plot_xy

def main():

    resultsLocation = 'PPO_multi_agent_sat_servicing_2024-05-09_23-24-0582uyvjcs/'

    #storageLocation = '/data_storage/training_data/'
    storageLocation = '/../ray_results/'
    results_dir = os.path.dirname(sys.path[1])+storageLocation+resultsLocation
    #results_file = results_dir+'result.json'
    results_file = results_dir+'progress.csv'

    count=0
    results=[]
    max_reward=[]
    min_reward=[]
    mean_reward=[]
    with open(results_file, newline='') as csvfile:
        data = csv.reader(csvfile, delimiter=',', quotechar='|')
        for row in data:
            count=count+1
            results.append(row)
            if count>1:
                max_reward.append(float(results[count-1][0]))
                min_reward.append(float(results[count-1][1]))
                mean_reward.append(float(results[count-1][2]))
            #print(', '.join(row))

    print('Finished Loading')

    legend=['Max','Min','Mean']
    colors=['orange','green','red']
    labels=['Total Episode Reward','Iteration','Reward']
    plotData={'data0':np.array(max_reward),'data1':np.array(min_reward),'data2':np.array(mean_reward),}
    plot_static('1d',plotData,labels,legend,colors)

    plt.show()
    return

if __name__ == "__main__":
    main()

