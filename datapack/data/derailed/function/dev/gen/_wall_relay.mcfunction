
# Builds the section again from its regions as they grew, for an attempt after
#  it has twice found no second way: the regions are put back from where
#  growing them left a copy, and the wall laid again here, then the rivers and
#  the stray sweep by their own steps, in the order they were done the first
#  time, so that everything after the seeds is fresh
# Positioned at the section's corner

function derailed:dev/gen/_lay_restore
clone ~ ~12 ~ ~31 ~12 ~15 ~ ~ ~ strict
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_lake

execute if score #gen_difficulty dr_var matches 2 run function derailed:dev/gen/wall
clone ~ ~ ~ ~31 ~ ~15 ~ ~5 ~ strict

scoreboard players set #q_relay dr_var 1
scoreboard players set #q_step dr_var 4
return 1
