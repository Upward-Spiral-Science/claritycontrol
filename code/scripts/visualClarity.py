#!/usr/bin/python
#-*- coding:utf-8 -*-
__author__ = 'david'
from __builtin__ import *

import imghdr
import numpy as np
import scipy as sp
from PIL import Image
from resources import DATAPATH

if __name__ == '__main__':
    # Fear199 540 717 452
    data = np.memmap(DATAPATH+"Fear199.img",dtype=np.uint8,shape=(717, 452, 540))
    im = Image.fromarray(data[:,:,200])
    im.show()
