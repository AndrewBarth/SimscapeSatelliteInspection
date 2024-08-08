import os
import csv
import pickle
from scipy.io import savemat
from scipy.io import loadmat

# save pickle
def save_pkl(content, fdir, fname):
    """
    Save content into path/name as pickle file
    Args:
        path: file path, str
        content: to be saved, array/dict/list...
        fname: file name, str
    """
    # Make directory if it does not already exist
    if not os.path.exists(fdir):
        os.makedirs(fdir)

    file_path = os.path.join(fdir, fname)
    with open(file_path, 'wb') as f:
        pickle.dump(content, f, pickle.HIGHEST_PROTOCOL)

def save_csv(content, fdir, fname):
    """
    Save content into path/name as csv file
    Args:
        content: to be saved, dict
        path: file path, str
        fname: file name, str
    """
    # Make directory if it does not already exist
    if not os.path.exists(fdir):
        os.makedirs(fdir)

    file_path = os.path.join(fdir, fname)
    with open(file_path, 'w') as f:
        for key in content.keys():
            f.write("{},{}\n".format(key,content[key]))

def save_mat(content, fdir, fname):
    """
    Save content into path/name as mat file
    Args:
        content: to be saved, dict
        path: file path, str
        fname: file name, str
    """
    # Make directory if it does not already exist
    if not os.path.exists(fdir):
        os.makedirs(fdir)

    file_path = os.path.join(fdir, fname)
    with open(file_path, 'w') as f:
        savemat(file_path, content) 

def load_mat(fdir, fname):
    """
    Load content from a mat file into into a numpy array
    Args:
        path: file path, str
        fname: file name, str
    """

    file_path = os.path.join(fdir, fname)
    data = loadmat(file_path)

    return data
    
