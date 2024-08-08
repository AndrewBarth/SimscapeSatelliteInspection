import os
import numpy as np

def format_mat_data(Data,caseTitle,caseName,mission,time_step):

    #npts = len(Data[0])
    npts = len(Data)

    # Create the time vector
    time_vec = np.arange(0,npts*time_step,time_step)

    if mission == 'Robotics':
        # For saving as mat file, first must place in dictionary
        outdata = {}
        outdata[caseName] = {}
        outdata[caseName]['Title'] = caseTitle
        outdata[caseName]['time'] = time_vec
        outdata[caseName]['sat'] = {}
        outdata[caseName]['ee'] = {}
        outdata[caseName]['arm'] = {}
        outdata[caseName]['ee']['position']    = Data[:,12:15]
        outdata[caseName]['ee']['orientation'] = Data[:,15:18]
        outdata[caseName]['ee']['velocity']    = Data[:,18:21]
        outdata[caseName]['ee']['ang_rate']    = Data[:,21:24]
        outdata[caseName]['ee']['position_error']    = Data[:,33:36]
        outdata[caseName]['ee']['orientation_error'] = Data[:,36:39]
        outdata[caseName]['ee']['velocity_error']    = Data[:,39:42]
        outdata[caseName]['ee']['ang_rate_error']    = Data[:,42:45]
        outdata[caseName]['arm']['jAngle'] = Data[:,24:27]
        outdata[caseName]['arm']['jRate']  = Data[:,27:30]
        outdata[caseName]['arm']['jCmd']   = Data[:,30:33]
        outdata[caseName]['arm']['jCmd']   = Data[:,30:33]
        outdata[caseName]['arm']['action'] = Data[:,45:48]

    elif mission == 'Inspection':
        outdata = {}
        outdata[caseName] = {}
        outdata[caseName]['Title'] = caseTitle
        outdata[caseName]['time'] = time_vec
        outdata[caseName]['cubesat'] = {}
        outdata[caseName]['cubesat']['position']      = Data[:,0:3]
        outdata[caseName]['cubesat']['velocity']      = Data[:,3:6]
        outdata[caseName]['cubesat']['acceleration']  = Data[:,6:9]
        outdata[caseName]['cubesat']['sim_time']      = Data[:,9]
        outdata[caseName]['cubesat']['nFaces']        = Data[:,10].astype(int)
        outdata[caseName]['cubesat']['nInspected']    = Data[:,11].astype(int)
        startIdx       = 12
        endIdx         = 12+outdata[caseName]['cubesat']['nFaces'][-1]
        outdata[caseName]['cubesat']['coverage ']     = Data[:,startIdx:endIdx].astype(int)
#        startIdx = endIdx
#        endIdx = endIdx+5
#        action         = trajData[:,startIdx:endIdx]
        startIdx = endIdx
        endIdx = endIdx+3
        outdata[caseName]['cubesat']['reward ']       = Data[:,startIdx:endIdx]
        startIdx = endIdx
        endIdx = endIdx+6
        outdata[caseName]['cubesat']['orbit']         = Data[:,startIdx:endIdx]

    return outdata

