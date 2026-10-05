
# Drops the tile at the back of the path, which moves every axle's tile one
#  nearer the start of it

data remove storage derailed:train path[0]
scoreboard players remove @e[type=marker,tag=dr_axle,distance=0..] dr_ai 1
