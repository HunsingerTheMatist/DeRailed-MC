
# Joins this river tile and the tiles either side of it to the lake where it
#  lies between two tiles of the river that touch the lake
# Run as the tile's marker, at it

execute store result score #lake_t dr_var if entity @e[type=marker,tag=dr_shore,distance=..1.1]
execute if score #lake_t dr_var matches ..1 run return 0
tag @s add dr_join
tag @e[type=marker,tag=dr_shore,distance=..1.1] add dr_join
