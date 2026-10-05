
# Lays barriers over every block from '#train_axle' along the path to '#left'
#  further on that the train covers all of, walking a tenth of a block at a
#  time with a trail on the block it last stood on, then goes
# Run as a new marker

function derailed:train/_axle_new
tag @s remove dr_train_new
execute at @s align xz positioned ~0.5 ~ ~0.5 summon marker run tag @s add dr_trail_lay
tag @e[type=marker,tag=dr_trail_lay,distance=0..] add dr_trail_first
function derailed:train/_reach_walk
kill @e[type=marker,tag=dr_trail_lay,distance=0..]
kill @s
