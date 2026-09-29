
# Gives '#mk' as its depth to every tile of iron or air still without one that
#  touches a tile '#mk' less deep, along a side or at a corner, then does the
#  same one deeper while any is left; a kind with 'round' set counts the tiles
#  at a corner only on odd steps

scoreboard players operation #mprev dr_var = #mk dr_var
scoreboard players remove #mprev dr_var 1
scoreboard players set #mdiag dr_var 1
execute if score #mround dr_var matches 1 run scoreboard players operation #mdiag dr_var = #mk dr_var
execute if score #mround dr_var matches 1 run scoreboard players operation #mdiag dr_var %= #m2 dr_var
execute as @e[type=marker,tag=dr_mt,scores={dr_md=-1},distance=0..] at @s run function derailed:dev/mound/_depth_at
scoreboard players add #mk dr_var 1
execute if score #mk dr_var matches ..32 if entity @e[type=marker,tag=dr_mt,scores={dr_md=-1},distance=0..] run function derailed:dev/mound/_depth
