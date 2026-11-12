
# Tags the river tile this one flows into 'dr_big_fed'
# Run as the river tile's marker, at it

execute if score @s dr_bdir matches 0 positioned ~ ~ ~-3 run tag @e[type=marker,tag=dr_big_river,distance=..0.5] add dr_big_fed
execute if score @s dr_bdir matches 1 positioned ~3 ~ ~ run tag @e[type=marker,tag=dr_big_river,distance=..0.5] add dr_big_fed
execute if score @s dr_bdir matches 2 positioned ~ ~ ~3 run tag @e[type=marker,tag=dr_big_river,distance=..0.5] add dr_big_fed
execute if score @s dr_bdir matches 3 positioned ~-3 ~ ~ run tag @e[type=marker,tag=dr_big_river,distance=..0.5] add dr_big_fed
