#!/usr/bin/python
#-*- coding:utf-8 -*-
__author__ = 'david'
from __builtin__ import *

import ndio
import ndio.remote.neurodata as ND
import pprint, json

import resources

def metaFile(token):
    return resources.METADATAPATH+"%s.meta"%(token)

def getMetaData(token):
    with open(metaFile(token)+".json",'r') as file:
        metaData = json.load(file)
    return metaData

def downloadMetaData(nd,token):
    metadata = nd.get_proj_info(token)
    return metadata

def main():
    nd = ND()

    print "Download and save meta datas."
    print 'ndio version = %s ... ...'%(ndio.version),

    for token in resources.TOKENS+resources.ANNO_TOKENS:
        print "Downloading meta TOKEN=%s"%(token)
        metaData = downloadMetaData(nd,token)
        filename = metaFile(token)
        with open(filename,'w') as file:
            pprint.pprint(metaData, file)

        with open(filename+".json",'w') as file:
            json.dump(metaData,file)
        print "OK"

    print "Finish all."

if __name__ == '__main__':
    main()
