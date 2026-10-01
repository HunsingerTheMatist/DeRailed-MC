
# Builds the large version of the section here
# Positioned at the section's corner, on its finished layer

kill @e[type=marker,tag=dr_big,distance=0..]

# The area is cleared a block wider all round than the tiles, which takes the
#  station's overhang and anything else that reaches past them
fill 1099 11 -1 1196 16 48 air strict
fill 1099 17 -1 1196 22 48 air strict
fill 1099 23 -1 1196 28 48 air strict
fill 1099 29 -1 1196 34 48 air strict
fill 1099 35 -1 1196 40 48 air strict

# The map the mounds read is the finished layer copied fourteen below, one tile
#  further out all round, with the station's building made ground on it so no
#  mound stands where the station does
clone ~-1 ~ ~-1 ~32 ~ ~16 ~-1 ~-14 ~-1 strict

# A marker on every tile that takes a structure, where its large version's
#  northwestern block stands, two below the ground
scoreboard players set #big_3 dr_temp 3
scoreboard players set #big_z dr_temp 0
function derailed:dev/big/_row
function derailed:dev/big/_cuts

execute as @e[type=marker,tag=dr_big,tag=!dr_big_tree,distance=0..] at @s run function derailed:dev/big/_place

# The station hangs a block over the tiles to its north and west, and its
#  structure voids leave what is under that as it is
execute as @e[type=marker,tag=dr_big_station,distance=0..] at @s run place template derailed:station ~-1 ~ ~-1 none none 1 0 strict

# The trees go up over the station's overhang where it reaches them
execute as @e[type=marker,tag=dr_big_tree,distance=0..] at @s run function derailed:dev/big/_tree

# The mounds go up last, over the station's overhang where it reaches them
scoreboard players set #mound_w dr_arg 32
scoreboard players set #mound_h dr_arg 16
scoreboard players set #mound_dx dr_arg 1100
scoreboard players set #mound_dy dr_arg 15
scoreboard players set #mound_dz dr_arg 0
scoreboard players set #mound_kind dr_arg 0
execute positioned ~ ~-14 ~ run function derailed:mound/build
scoreboard players set #mound_kind dr_arg 1
execute positioned ~ ~-14 ~ run function derailed:mound/build
fill ~-1 ~-14 ~-1 ~32 ~-14 ~16 air strict
execute as @e[type=marker,tag=dr_big_station,distance=0..] at @s positioned ~-1 ~ ~-1 run function derailed:dev/big/_station_edge

kill @e[type=marker,tag=dr_big,distance=0..]
