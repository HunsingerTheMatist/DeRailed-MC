
# Sets '#big_d' to the first way, of east, south, north and west, a lake lies
#  beside this tile
# Positioned on the tile's marker

execute if score #big_d dr_temp matches 0 positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_lake,distance=..0.5] run scoreboard players set #big_d dr_temp 1
execute if score #big_d dr_temp matches 0 positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_lake,distance=..0.5] run scoreboard players set #big_d dr_temp 2
execute if score #big_d dr_temp matches 0 positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_lake,distance=..0.5] run scoreboard players set #big_d dr_temp 3
execute if score #big_d dr_temp matches 0 positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_lake,distance=..0.5] run scoreboard players set #big_d dr_temp 4
