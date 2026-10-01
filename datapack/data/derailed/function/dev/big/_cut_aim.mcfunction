
# Tags this cut tile with the way it flows: toward the tile of the run numbered
#  after it, or, the last of the run, into the water it opens onto, a lake
#  where the run comes from a river, looking east, south, north then west
# Run as the tile's marker, at it

scoreboard players operation #big_k1 dr_temp = @s dr_bord
scoreboard players add #big_k1 dr_temp 1
scoreboard players set #big_d dr_temp 0
execute positioned ~3 ~ ~ as @e[type=marker,tag=dr_big_in,distance=..0.5] if score @s dr_bord = #big_k1 dr_temp run scoreboard players set #big_d dr_temp 1
execute positioned ~ ~ ~3 as @e[type=marker,tag=dr_big_in,distance=..0.5] if score @s dr_bord = #big_k1 dr_temp run scoreboard players set #big_d dr_temp 2
execute positioned ~ ~ ~-3 as @e[type=marker,tag=dr_big_in,distance=..0.5] if score @s dr_bord = #big_k1 dr_temp run scoreboard players set #big_d dr_temp 3
execute positioned ~-3 ~ ~ as @e[type=marker,tag=dr_big_in,distance=..0.5] if score @s dr_bord = #big_k1 dr_temp run scoreboard players set #big_d dr_temp 4

execute if score #big_d dr_temp matches 0 if score #big_both dr_temp matches 1 run function derailed:dev/big/_cut_aim_lake
execute if score #big_d dr_temp matches 0 run function derailed:dev/big/_cut_aim_water

execute if score #big_d dr_temp matches 0..1 run tag @s add dr_big_e
execute if score #big_d dr_temp matches 2 run tag @s add dr_big_s
execute if score #big_d dr_temp matches 3 run tag @s add dr_big_n
execute if score #big_d dr_temp matches 4 run tag @s add dr_big_w
