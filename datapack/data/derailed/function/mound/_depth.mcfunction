
# Gives '#mk' as its depth to every tile of the kind or air still without one
#  that touches a tile '#mk' less deep, along a side or at a corner, then does
#  the same one deeper while any is left; with '#mround' set the tiles at a
#  corner count only on odd steps

scoreboard players operation #mprev dr_temp = #mk dr_temp
scoreboard players remove #mprev dr_temp 1
scoreboard players set #mdiag dr_temp 1
execute if score #mround dr_temp matches 1 run scoreboard players operation #mdiag dr_temp = #mk dr_temp
execute if score #mround dr_temp matches 1 run scoreboard players operation #mdiag dr_temp %= #m2 dr_temp
execute as @e[type=marker,tag=dr_mound_t,scores={dr_md=-1},distance=0..] at @s run function derailed:mound/_depth_at
scoreboard players add #mk dr_temp 1
execute if score #mk dr_temp matches ..32 if entity @e[type=marker,tag=dr_mound_t,scores={dr_md=-1},distance=0..] run function derailed:mound/_depth
