#!/usr/bin/python
#-*- coding:utf-8 -*-
__author__ = 'david'
from __builtin__ import *

import gc
import numpy as np
from skimage.feature import greycomatrix, greycoprops
import matplotlib as mpl
mpl.use('TkAgg')  # Solve runtime issue
import matplotlib.pyplot as plt



## Fake imge and label volumes to fast test functionality
def loadImg():
    return np.random.random_sample((100,100,100))

def loadAtlas():
    atlas_volume = np.zeros((100,100,100),dtype=np.uint32)
    atlas_volume[10:50,10:50,10:50]=np.ones((40,40,40),dtype=np.uint32)*1
    atlas_volume[50:90,10:50,10:50]=np.ones((40,40,40),dtype=np.uint32)*2
    atlas_volume[10:50,50:90,10:50]=np.ones((40,40,40),dtype=np.uint32)*3
    atlas_volume[50:90,50:90,10:50]=np.ones((40,40,40),dtype=np.uint32)*4
    atlas_volume[10:50,10:50,50:90]=np.ones((40,40,40),dtype=np.uint32)*5
    atlas_volume[50:90,10:50,50:90]=np.ones((40,40,40),dtype=np.uint32)*6
    atlas_volume[10:50,50:90,50:90]=np.ones((40,40,40),dtype=np.uint32)*7
    atlas_volume[50:90,50:90,50:90]=np.ones((40,40,40),dtype=np.uint32)*8
    return atlas_volume

## END

## True data

# path = "~/Workspaces/claritycontrol/code/data/raw/"
# token = "Fear199"
# pathname = path+token+".img"
#
# img_volume = nib.load(pathname).get_data()[:,:,:,0]

## END

## get atlas values
atlas_volume = loadAtlas()
print atlas_volume.shape
atlas_values, atlas_count = np.unique(atlas_volume,return_counts=True)
atlas_values = atlas_values[1:]  # remove background

## get img
img_volume = loadImg()
print img_volume.shape

class_id = 0 # Fear, Control, Cocaine
subject_id = 199

## normalize volume Z-standardization
img_volume = (img_volume-np.mean(img_volume))/np.std(img_volume)

## prepare results matrix
columns = ['class_id', 'subject_id', 'roi', 'mean', 'std', 'energy', 'entropy', 'correlation', 'contrast', 'variance', 'sumMean',
           'inertial', 'clusterShade', 'clusterTendency', 'homogeneity', 'maxProbability', 'inverseVariance']
features = np.zeros((len(atlas_values), len(columns)), dtype=np.float32)

## compute GLCM and properties
for roi_id in range(len(atlas_values)):
    features[roi_id, 0] = class_id
    features[roi_id, 1] = subject_id
    features[roi_id, 2] = atlas_values[roi_id]

    ## mask img and get roi block
    mask_volume = (atlas_volume == atlas_values[roi_id])
    xs, ys, zs = mask_volume.nonzero()
    roi_block = np.multiply(img_volume, mask_volume)[min(xs):max(xs), min(ys):max(ys), min(zs):max(zs)]
    del mask_volume  # memory collect

    ## compute mean and std
    features[roi_id, 3] = np.mean(roi_block[roi_block != 0])
    features[roi_id, 4] = np.std(roi_block[roi_block != 0])

    ## compute GLCM and properties
    # features[roi_id, 5] = 0
    # features[roi_id, 6] = 0
