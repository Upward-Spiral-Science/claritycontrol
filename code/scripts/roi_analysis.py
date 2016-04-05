#!/usr/bin/python
#-*- coding:utf-8 -*-
__author__ = 'david'
from __builtin__ import *


#ssh alee@foo.cis.jhu.edu
#unko1234
#/cis/project/clarity/data/clarity/level5/

import clarity.resources as rs
import nibabel as nib
import numpy as np
import matplotlib.pyplot as plt
import jgraph as ig
import csv,gc  # garbage memory collection :)

#%matplot_lib inline

path = rs.RAW_DATA_PATH
token = "Fear199"
pathname = path+token+".img"
img_volume = nib.load(pathname).get_data()[:,:,:,0]
normalized_volume = (img_volume-np.mean(img_volume))/np.std(img_volume)

