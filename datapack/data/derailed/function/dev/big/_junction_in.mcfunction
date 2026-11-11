
# Tags this river tile's marker with the way each river flowing into it flows,
#  'dr_big_in_n', 'dr_big_in_e', 'dr_big_in_s' or 'dr_big_in_w'
# Run as the tile's marker, at it

execute positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_n,distance=..0.5] run tag @s add dr_big_in_n
execute positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_e,distance=..0.5] run tag @s add dr_big_in_e
execute positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_s,distance=..0.5] run tag @s add dr_big_in_s
execute positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_w,distance=..0.5] run tag @s add dr_big_in_w
