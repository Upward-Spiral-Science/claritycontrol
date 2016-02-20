#!/usr/bin/python
#-*- coding:utf-8 -*-
__author__ = 'david'
from __builtin__ import *

import clarity as cl

c = cl.Clarity("Fear199")
# c.loadImg().imgToPoints(threshold=50,sample=0.5,optimize=True).savePoints()
c.loadPoints().show()
