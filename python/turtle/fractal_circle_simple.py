import math
from turtle import *

def cosd(degs):
    return math.cos(math.radians(degs))

def sind(degs):
    return math.sin(math.radians(degs))

def drawCircles(pt, iterations, initAngle, r):
    length = iterations
    x2 = length * cosd(initAngle) + pt[0]
    y2 = length * sind(initAngle) + pt[1]
    penup()
    #TODO needs to scale to screen size
    #FIXIT fix off-screen drawing bug
    goto(x2,y2)
    pendown()
    fillcolor((iterations/r, 1-iterations/r, 1))
    begin_fill()
    circle(length/2)
    end_fill()
    if iterations > 1:
        drawCircles((x2,y2), iterations - 1, initAngle + 20, r)
        
def fractalCircleSimple(r):
    drawCircles((r/2, r/2), r, 90, r)

fractalCircleSimple(150)
