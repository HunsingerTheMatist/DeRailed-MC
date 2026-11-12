
# Follows the stretch from the river tile nothing flows into with the longest
#  river below it of those left, the one nearest a point no two can be equally
#  near where two are as long, then the next, until none is left

scoreboard players set #s_max dr_temp 0
execute as @e[type=marker,tag=dr_big_river,tag=!dr_big_fed,tag=!dr_big_src_done,distance=0..] run scoreboard players operation #s_max dr_temp > @s dr_blen
execute if score #s_max dr_temp matches 0 run return 0
execute as @e[type=marker,tag=dr_big_river,tag=!dr_big_fed,tag=!dr_big_src_done,distance=0..] if score @s dr_blen = #s_max dr_temp run tag @s add dr_big_src_tie
execute positioned 1099.37 0.0 -0.71 as @e[type=marker,tag=dr_big_src_tie,distance=0..,sort=nearest,limit=1] at @s run function derailed:dev/big/_south_stretch
tag @e[type=marker,tag=dr_big_src_tie,distance=0..] remove dr_big_src_tie
function derailed:dev/big/_south_next
