
# Moves this marker a tenth of a block along the path at a time while '#left'
#  has more to go, laying barriers over each block it passes all of
# A tenth is short enough that a corner's middle block, which its turn only
#  cuts across, is still stepped on
# Run as the walking marker

execute at @s align xz positioned ~0.5 ~ ~0.5 unless entity @e[type=marker,tag=dr_trail_lay,distance=..0.1] run function derailed:train/_reach_lay_moved
execute if score #left dr_temp matches ..0 run return 0
scoreboard players remove #left dr_temp 100
scoreboard players add @s dr_ad 100
execute if score @s dr_ad >= @s dr_alen run function derailed:train/_axle_next
function derailed:train/_axle_pos
function derailed:train/_reach_walk
