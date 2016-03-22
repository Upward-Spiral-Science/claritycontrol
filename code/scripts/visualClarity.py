#!/usr/bin/python
#-*- coding:utf-8 -*-
__author__ = 'david'
from __builtin__ import *

import numpy as np
import scipy as sp
import nibabel as nib
import clarity.resources as rs
import clarity as cl
import gc
from OpenGL.GL import *
from OpenGL.GLU import *
from OpenGL.GLUT import *

DATAPATH = "/Users/albertlee/claritycontrol/code/data/"
data = None

def drawClarity():
    glClear(GL_COLOR_BUFFER_BIT)
    glRotatef(1, 0, 1, 0)

    glDrawArrays(GL_POINTS,0,1000)
    glFlush()

def main():
    img = nib.load(DATAPATH+"Fear199.img")
    data = img.get_data()

    #openGL
    glutInit()
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGBA)
    glutInitWindowSize(1000, 1000)
    glutCreateWindow("First")
    glutDisplayFunc(drawClarity)
    glutIdleFunc(drawClarity)
    glutMainLoop()

if __name__ == '__main__':
    main()
