#!/usr/bin/python
#-*- coding:utf-8 -*-
__author__ = 'david'
from __builtin__ import *

import ndio
import ndio.remote.neurodata as ND
import numpy as np
import pprint

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
    # pprint.pprint(metaData,indent=4)
    imagesSizes = metaData['dataset']['imagesize']
    offset = metaData['dataset']['offset']

    n = u'5' # resolution
    print "ndio get cutout ... TOKEN=%s CHANNEL=%s RESOLUTION=%s"%(TOKEN,CHANNEL,n)
    data = nd.get_cutout(TOKEN,CHANNEL,
                        0,imagesSizes[n][0],
                        0,imagesSizes[n][1],
                        0,imagesSizes[n][2],
                        resolution=int(n))
    #data = nd.get_cutout(TOKEN,CHANNEL,
    #                    0,100,
    #                    0,100,
    #                    0,100,
    #                    resolution=int(n))
    #pprint.pprint(data,indent=2)

    outFile = DATAPATH+'%s_%s_%s.csv'%(TOKEN,CHANNEL,n)
    np.savetxt(outFile,
                data,
                delimiter=',',fmt='%u')
    print "... Finished ... OUTPUT=%s"%(outFile)

if __name__ == '__main__':
    main()
