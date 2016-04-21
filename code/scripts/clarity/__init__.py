#!/usr/bin/python
#-*- coding:utf-8 -*-
__author__ = 'david'

import numpy as np
import nibabel as nib
import resources as rs
from vispy import app
from plot import Canvas
import matplotlib.pyplot as plt
import gc

np.random.seed()

class Clarity(object):
    def __init__(self,token,imgfile=None,pointsfile=None):
        if token not in rs.TOKENS:
            raise ValueError("Token %s not found."%(token))

        self._token = token
        self._imgfile = imgfile
        self._pointsfile = pointsfile
        self._img = None     # img data
        self._points = None  # [[x],[y],[z],[v]]
        self._shape = None   # (x,y,z)
        self._max = None     # max value

    def loadImg(self, path=None, info=False):
        if path is None:
            path = rs.RAW_DATA_PATH

        pathname = path+self._token+".img"
        img = nib.load(pathname)
        if info:
            print(img)
        self._img = img.get_data()[:,:,:,0]
        self._shape = self._img.shape
        self._max = np.max(self._img)
        print("Image Loaded: %s"%(pathname))
        return self

    def getShape(self):
        return self._shape

    def getMax(self):
        return self._max

    def discardImg(self):
        del self._img
        gc.collect()
        return self

    def getHistogram(self,bins,range,density=True):
        if self._img is None:
            raise ValueError("Img haven't loaded, please call loadImg() first.")

        return np.histogram(self._img.flatten(), bins=bins, range=range, density=density)

    def imgToPoints(self, threshold=0.1, sample=0.5, optimize=True):
        if not 0 <= threshold < 1:
            raise ValueError("Threshold should be within [0,1).")
        if not 0 < sample <= 1:
            raise ValueError("Sample rate should be within (0,1].")
        if self._img is None:
            raise ValueError("Img haven't loaded, please call loadImg() first.")

        total = self._shape[0]*self._shape[1]*self._shape[2]
        print("Coverting to points...\ntoken=%s\ntotal=%d\nmax=%f\nthreshold=%f\nsample=%f"\
               %(self._token,total,self._max,threshold,sample))
        print("(This will take couple minutes)")
        # threshold
        filt = self._img > threshold * self._max
        x, y, z = np.where(filt)
        v = self._img[filt]
        if optimize:
            self.discardImg()
        v = np.int16(255*(np.float32(v)/np.float32(self._max)))
        l = v.shape
        print("Above threshold=%d"%(l))
        # sample
        if sample < 1.0:
            filt = np.random.random(size=l) < sample
            x = x[filt]
            y = y[filt]
            z = z[filt]
            v = v[filt]
        self._points = np.vstack([x,y,z,v])
        self._points = np.transpose(self._points)
        print("Samples=%d"%(self._points.shape[0]))
        print("Finished")
        return self

    def loadPoints(self,path=None):
        if path is None:
            path = rs.POINTS_DATA_PATH
        pathname = path+self._token+".csv"
        self._points = np.loadtxt(pathname,dtype=np.int16,delimiter=',')
        print("Points Loaded: %s"%(pathname))
        return self

    def savePoints(self,path=None):
        if self._points is None:
            raise ValueError("Points is empty, please call imgToPoints() first.")

        if path is None:
            path = rs.POINTS_DATA_PATH
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

    def histogramEqualize(self,scale=30):
        # get image histogram
        imhist, bins = np.histogram(self._points[:,3],256,density=True)
        cdf = imhist.cumsum()         # cumulative distribution function
        cdf = scale * cdf / cdf[-1]   # normalize
        # use linear interpolation of cdf to find new pixel values
        return np.interp(self._points[:,3],bins[:-1],cdf)

    def showHistogram(self,bins=255):
        plt.hist(self._points[:,3],bins=bins)
        plt.title("%s Points Histogram"%(self._token))
        plt.ylabel("count")
        plt.xlabel("level")
        plt.grid()
        plt.show()

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

        brighter = 0.05
        colors[:,0]/=mx+brighter
        colors[:,1]/=my+brighter
        colors[:,2]/=mz+brighter

        alpha = np.empty((len(colors[:,0]),1))
        alpha.fill(0.8)
        colors = np.hstack([colors,alpha])
        # sizes
        sizes = self.histogramEqualize()

        # visualize
        c = Canvas(self._points[:,:3],colors,sizes)
        app.run()

if __name__ == '__main__':
    pass
