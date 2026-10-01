
# Builds mounds of kind '#mound_kind', 0 iron or 1 rock, from a map of tiles,
#  three blocks to a tile: every tile of the kind in the '#mound_w' by
#  '#mound_h' tiles of the map becomes a mound of columns on the ground from
#  '#mound_dx' '#mound_dy' '#mound_dz', lowest at the edge of its region and
#  highest furthest in, on two blocks below the ground, polished andesite
#  under iron and deepslate under rock
# Iron is light gray concrete on the map and rock gray concrete; a tile of air
#  carries the mound on past it, so the map wants the tiles one out round it
#  too
# Nothing is cleared, so the ground and the air over it want to be clear
# Takes its random numbers from 'derailed:terrain'
# Positioned at the map's northwestern tile, in the dimension the map and the
#  mounds are in

execute if score #mound_kind dr_arg matches 0 run function derailed:mound/_config_iron
execute if score #mound_kind dr_arg matches 1 run function derailed:mound/_config_rock
scoreboard players set #m2 dr_temp 2
scoreboard players set #m3 dr_temp 3
scoreboard players set #m16 dr_temp 16
scoreboard players set #m36 dr_temp 36
scoreboard players set #m100 dr_temp 100

kill @e[type=marker,tag=dr_mound_t,distance=0..]
kill @e[type=marker,tag=dr_mound_c,distance=0..]
kill @e[type=marker,tag=dr_mound_at,distance=0..]

# A marker on every tile of the map and of a ring one tile out round it, which
#  says whether the mound goes on past the map's edge, and on every corner
#  between the map's tiles, a layer above
scoreboard players set #mj dr_temp -1
execute positioned ~-1 ~ ~-1 run function derailed:mound/_lay_row

# How far in from the edge of its region every tile of the kind is, counting in
#  only from tiles that are neither the kind nor air; one no such tile is
#  anywhere near is as far in as a tile can be
scoreboard players set #mk dr_temp 1
function derailed:mound/_depth
scoreboard players set @e[type=marker,tag=dr_mound_t,scores={dr_md=-1},distance=0..] dr_md 32

# How high every corner stands, from how far in it is, then a few peaks
execute as @e[type=marker,tag=dr_mound_c,distance=0..] at @s run function derailed:mound/_corner
function derailed:mound/_peaks

# Each tile is built where a marker is moved to, three blocks to every tile
execute summon marker run tag @s add dr_mound_at
execute as @e[type=marker,tag=dr_mound_t,tag=!dr_mound_ring,scores={dr_mi=1},distance=0..] at @s run function derailed:mound/_tile

kill @e[type=marker,tag=dr_mound_t,distance=0..]
kill @e[type=marker,tag=dr_mound_c,distance=0..]
kill @e[type=marker,tag=dr_mound_at,distance=0..]
