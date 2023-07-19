import os
import numpy as np

def format_mat_data(Data,caseTitle,caseName,time_step):

    npts = len(Data[0])

    # Create the time vector
    time_vec = np.arange(0,npts*time_step,time_step)

    # For saving as mat file, first must place in dictionary
    outdata = {}
    outdata[caseName] = {}
    outdata[caseName]['Title'] = caseTitle
    outdata[caseName]['time'] = time_vec
    outdata[caseName]['sat'] = {}
    outdata[caseName]['ee'] = {}
    outdata[caseName]['arm'] = {}
    outdata[caseName]['ee']['position']    = Data[0,:,12:15]
    outdata[caseName]['ee']['orientation'] = Data[0,:,15:18]
    outdata[caseName]['ee']['velocity']    = Data[0,:,18:21]
    outdata[caseName]['ee']['ang_rate']    = Data[0,:,21:24]
    outdata[caseName]['ee']['position_error']    = Data[0,:,33:36]
    outdata[caseName]['ee']['orientation_error'] = Data[0,:,36:39]
    outdata[caseName]['ee']['velocity_error']    = Data[0,:,39:42]
    outdata[caseName]['ee']['ang_rate_error']    = Data[0,:,42:45]
    outdata[caseName]['arm']['jAngle'] = Data[0,:,24:27]
    outdata[caseName]['arm']['jRate']  = Data[0,:,27:30]
    outdata[caseName]['arm']['jCmd']   = Data[0,:,30:33]
    outdata[caseName]['arm']['jCmd']   = Data[0,:,30:33]
    outdata[caseName]['arm']['action'] = Data[0,:,45:48]

    return outdata

