
# Tries the side held in 'rw' on every corner the walk kept, and takes it if
#  no corner's tile carves a prefab or lies in column 0

scoreboard players set #riv_bad dr_var 0
execute as @e[type=marker,tag=dr_riv_keep,distance=0..] at @s run function derailed:dev/gen/_river_side_at
execute if score #riv_bad dr_var matches 0 run scoreboard players set #riv_side dr_var 1
