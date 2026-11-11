
# Gives this rock tile '#ch_k' as its depth where a tile beside it along a side
#  is '#ch_k' less deep
# Run as the tile's marker, at it

scoreboard players operation #ch_prev dr_temp = #ch_k dr_temp
scoreboard players remove #ch_prev dr_temp 1
scoreboard players set #ch_f dr_temp 0
execute if score #ch_k dr_temp matches 1 positioned ~3 ~ ~ unless entity @e[type=marker,tag=dr_big_rock,distance=..0.5] run scoreboard players set #ch_f dr_temp 1
execute if score #ch_k dr_temp matches 1 positioned ~-3 ~ ~ unless entity @e[type=marker,tag=dr_big_rock,distance=..0.5] run scoreboard players set #ch_f dr_temp 1
execute if score #ch_k dr_temp matches 1 positioned ~ ~ ~3 unless entity @e[type=marker,tag=dr_big_rock,distance=..0.5] run scoreboard players set #ch_f dr_temp 1
execute if score #ch_k dr_temp matches 1 positioned ~ ~ ~-3 unless entity @e[type=marker,tag=dr_big_rock,distance=..0.5] run scoreboard players set #ch_f dr_temp 1
execute if score #ch_k dr_temp matches 2.. positioned ~3 ~ ~ as @e[type=marker,tag=dr_big_rock,distance=..0.5] if score @s dr_bd = #ch_prev dr_temp run scoreboard players set #ch_f dr_temp 1
execute if score #ch_k dr_temp matches 2.. positioned ~-3 ~ ~ as @e[type=marker,tag=dr_big_rock,distance=..0.5] if score @s dr_bd = #ch_prev dr_temp run scoreboard players set #ch_f dr_temp 1
execute if score #ch_k dr_temp matches 2.. positioned ~ ~ ~3 as @e[type=marker,tag=dr_big_rock,distance=..0.5] if score @s dr_bd = #ch_prev dr_temp run scoreboard players set #ch_f dr_temp 1
execute if score #ch_k dr_temp matches 2.. positioned ~ ~ ~-3 as @e[type=marker,tag=dr_big_rock,distance=..0.5] if score @s dr_bd = #ch_prev dr_temp run scoreboard players set #ch_f dr_temp 1
execute if score #ch_f dr_temp matches 1 run scoreboard players operation @s dr_bd = #ch_k dr_temp
