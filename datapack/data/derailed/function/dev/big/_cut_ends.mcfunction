
# Tags this cut tile 'dr_big_end_lake' where a lake lies beside it and
#  'dr_big_end_riv' where a river the walk laid does
# Run as the tile's marker, at it

execute positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_lake,distance=..0.5] run tag @s add dr_big_end_lake
execute positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_lake,distance=..0.5] run tag @s add dr_big_end_lake
execute positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_lake,distance=..0.5] run tag @s add dr_big_end_lake
execute positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_lake,distance=..0.5] run tag @s add dr_big_end_lake
execute positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_river,tag=!dr_big_cut,distance=..0.5] run tag @s add dr_big_end_riv
execute positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_river,tag=!dr_big_cut,distance=..0.5] run tag @s add dr_big_end_riv
execute positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_river,tag=!dr_big_cut,distance=..0.5] run tag @s add dr_big_end_riv
execute positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_river,tag=!dr_big_cut,distance=..0.5] run tag @s add dr_big_end_riv
