
# Gives '#pl_kind' to '#pl_left' of the seeds still to be placed, at random

execute if score #pl_left dr_var matches ..0 run return 0
tag @e[type=marker,tag=dr_place,distance=0..] add dr_pickc
function derailed:dev/gen/_pick
execute as @e[type=marker,tag=dr_picked,distance=0..] run function derailed:dev/gen/_kind_give
scoreboard players remove #pl_left dr_var 1
function derailed:dev/gen/_kind_rest
