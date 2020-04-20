import math
from turtle import *

def cosd(degs):
    return math.cos(math.radians(degs))

def sind(degs):
    return math.sin(math.radians(degs))

def drawFern(pt, num_branches, direction, init_angle, length1, r):
    index = num_branches
    angle = init_angle
    x2 = pt[0]
    y2 = pt[1]
    next_side = 1
    while index > 0:
        length = length1 * .9**(num_branches-index)
        if length < .05:
            return
        
        if next_side == 1:
            next_side = 0
            next_angle = angle - 50
        else:
            next_side = 1
            next_angle = angle + 50
            
        if direction == 1:
            angle = angle - 2
        else:
            angle = angle + 2

        xdraw = length * cosd(angle) + x2
        ydraw = length * sind(angle) + y2
        c = (0, 1-(.7*(index/r)), 0)
        speed(0)
        pencolor(c)
        pensize(length/2)
        penup()
        goto(x2,y2)
        pendown()
        goto(xdraw,ydraw)
        x2, y2 = xdraw, ydraw
        drawFern((x2,y2), index - 1, next_side, next_angle, length/2.5, r)
        index = index - 1
        
def fractalFern(r):
    drawFern((0,0), r, 1, 90, 10, r)

screen = Screen()
screen.setworldcoordinates(-50,-5,50,95)
fractalFern(5)
