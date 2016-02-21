#!/usr/bin/python
#-*- coding:utf-8 -*-
__author__ = 'david'
from __builtin__ import *

import clarity.resources as rs
import clarity as cl

c = cl.Clarity("Fear199")
c.loadImg().imgToPoints(threshold=0.01,sample=0.5,optimize=True).savePoints()
#c.loadPoints().show()

def allToPoints():
    for token in rs.TOKENS+rs.ANNO_TOKENS:
        c = cl.Clarity(token)
        c.loadImg().imgToPoints(threshold=50,sample=1,optimize=True).savePoints()

