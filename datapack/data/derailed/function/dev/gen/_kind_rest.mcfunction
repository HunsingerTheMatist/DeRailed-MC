
# Gives '#pl_kind' to '#pl_left' of the seeds still to be placed, at random

execute if score #pl_left dr_var matches ..0 run return 0
execute as @e[type=marker,tag=dr_place,distance=0..,sort=random,limit=1] run function derailed:dev/gen/_kind_give
scoreboard players remove #pl_left dr_var 1
function derailed:dev/gen/_kind_rest
