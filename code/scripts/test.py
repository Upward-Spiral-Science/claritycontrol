#!/usr/bin/python
#-*- coding:utf-8 -*-
__author__ = 'david'
from __builtin__ import *

import clarity.resources as rs
import clarity as cl
import gc

c = cl.Clarity("Cocaine175")
#c.loadImg().imgToPoints(threshold=0.01,sample=0.5,optimize=True).savePoints()
# c.loadPoints().show()

c.loadPoints().showHistogram(bins=256)

def allToPoints():
    for token in rs.TOKENS:
        print "token",token
        c = cl.Clarity(token)
        c.loadImg().imgToPoints(threshold=0.08,sample=1.0,optimize=True).savePoints()
        del c
        gc.collect()
