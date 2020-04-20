import random
from turtle import *

p = (0,0)
screen = Screen()
screen.setworldcoordinates(-6,-1,6,11)

def draw_branch(p,c):
    if c > 9999:
        return
    c = c + 1
    
    penup()
    goto(p)
    dot(2,'green')
    r = random.uniform(0,1)
    if r < 0.01:
        draw_branch((0,0.16*p[1]), c)
    elif r < 0.86:
        draw_branch((0.85*p[0] + 0.04*p[1], -0.04*p[0] + 0.85*p[1] + 1.6), c)
    elif r < 0.93:
        draw_branch((0.2*p[0] - 0.26*p[1], 0.23*p[0] + 0.22*p[1] + 1.6), c)
    else:
        draw_branch((-0.15*p[0] + 0.28*p[1], 0.26*p[0] + 0.24*p[1] + 0.44), c)

       
draw_branch(p,0)
