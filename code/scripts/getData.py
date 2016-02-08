#!/usr/bin/python
#-*- coding:utf-8 -*-
__author__ = 'david'
from __builtin__ import *

import ndio
import ndio.remote.neurodata as ND
import numpy as np

TOKEN = 'fear199'
CHANNEL = 'grayscale'
DATAPATH = '../data/'

nd = ND()

def getMetaData(token):
    metadata = nd.get_proj_info(token)
    return metadata

def main():
    print 'ndio version =',ndio.version

    metaData = getMetaData(TOKEN)
    imagesSizes = metaData['dataset']['imagesize']
    offset = metaData['dataset']['offset']

    for n,off in offset.iteritems():
        print "Downloading ...",n,"...",
        #with open(DATAPATH+'%s-%s-%s.data'%(TOKEN,CHANNEL,n),'w') as output:
        data = nd.get_cutout(TOKEN,CHANNEL,
                            offset[n][0],imagesSizes[n][0],
                            offset[n][1],imagesSizes[n][1],
                            offset[n][2],imagesSizes[n][2],
                            resolution=3,
                            block_size=(128,128,16))
        np.savetxt(DATAPATH+'%s-%s-%s.csv'%(TOKEN,CHANNEL,n),
                   data,
                   delimiter=',')
        print "...Finished"

if __name__ == '__main__':
    main()
