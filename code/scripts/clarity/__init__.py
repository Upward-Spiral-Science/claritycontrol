#!/usr/bin/python
#-*- coding:utf-8 -*-
__author__ = 'david'
from __builtin__ import *

import numpy as np
import nibabel as nib
import resources as rs
from vispy import app
from plot import Canvas
import random

random.seed()

class Clarity(object):
    def __init__(self,token,imgfile=None,pointsfile=None):
        if not (token in rs.TOKENS or token in rs.ANNO_TOKENS):
            raise ValueError("Token %s not found."%(token))

        self._token = token
        self._imgfile = imgfile
        self._pointsfile = pointsfile
        self._img = None   # img data
        self._points=None  # [[x],[y],[z],[v]]

    def loadImg(self,path=None,info=True):
        if path is None:
            path = rs.DATAPATH
        pathname = path+self._token+".img"
        img = nib.load(pathname)
        if info:
            print(img)
        print("Image Loaded: %s"%(pathname))
        self._img = img.get_data()[:,:,:,0]
        return self

    def discardImg(self):
        self._img = None
        return self

    def imgToPoints(self,threshold=50,sample=1,optimize=True):
        if not 0<threshold<255:
            raise ValueError("Threshold should be within (0,255).")
        if not 0<sample<=1:
            raise ValueError("Sample rate should be within (0,1].")
        if self._img is None:
            raise ValueError("Img haven't loaded, please call loadImg() first.")

        points = []
        m = np.max(self._img)
        for (i,j,k),v in np.ndenumerate(self._img):
            v = np.int16(255*v/m)
            if v > threshold and random.random() <= sample:
                points.append([i,j,k,v])

        if optimize:
            self.discardImg()

        self._points = np.array(points,dtype=np.int16)
        return self

    def loadPoints(self,path=None):
        if path is None:
            path = rs.POINTSPATH
        pathname = path+self._token+".csv"
        self._points = np.loadtxt(pathname,dtype=np.int16,delimiter=',')
        print("Points Loaded: %s"%(pathname))
        return self

    def savePoints(self,path=None):
        if self._points is None:
            raise ValueError("Points is empty, please call imgToPoints() first.")
        if path is None:
            path = rs.POINTSPATH
        pathname = path+self._token+".csv"
        np.savetxt(pathname,self._points,fmt='%d',delimiter=',')
        return self

    def centralize(self):
        # Centralize the data
        # use mean or median
        centerX = np.mean(self._points[:,0])
        centerY = np.mean(self._points[:,1])
        centerZ = np.mean(self._points[:,2])
        self._points[:,0] -= np.int16(centerX)
        self._points[:,1] -= np.int16(centerY)
        self._points[:,2] -= np.int16(centerZ)
        return self

    def histogramEqualize(self,scale=25):
        # get image histogram
        imhist, bins = np.histogram(self._points[:,3],256,density=True)
        cdf = imhist.cumsum()         # cumulative distribution function
        cdf = scale * cdf / cdf[-1]   # normalize

        # use linear interpolation of cdf to find new pixel values
        return np.interp(self._points[:,3],bins[:-1],cdf)

    def show(self):
        if self._points is None:
            raise ValueError("Points is empty, please call imgToPoints() first.")
        # centralize
        self.centralize()
        # colors
        colors = np.array(np.abs(self._points[:,:3]),dtype=np.float32)
        mx = np.max(colors[:,0])
        my = np.max(colors[:,1])
        mz = np.max(colors[:,2])

        brighter = 0.2
        colors[:,0]/=mx+brighter
        colors[:,1]/=my+brighter
        colors[:,2]/=mz+brighter

        alpha = np.empty((len(colors[:,0]),1))
        alpha.fill(1.0)
        colors = np.hstack([colors,alpha])
        # sizes
        sizes = self.histogramEqualize()
        # visualize
        c = Canvas(self._points[:,:3],colors,sizes)
        app.run()

if __name__ == '__main__':
    pass
