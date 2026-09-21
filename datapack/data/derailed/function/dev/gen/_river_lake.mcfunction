
# Turns one of the regions the river ran out against into water
# Positioned on the corner the river ends at

# The last of the river stands on this corner, so the tiles it touches are the
#  four around it, and whichever of them the lake falls to is drawn evenly
# The one the river came in over is among them and is turned away for being river
#  already, and a tile off the edge of the section reads as nothing at all, so
#  both drop out of the draw on their own
scoreboard players set #lake_n dr_var 0
scoreboard players set #lake_id dr_var -1

execute positioned ~-1 ~ ~ run function derailed:dev/gen/_river_lake_see
execute positioned ~1 ~ ~ run function derailed:dev/gen/_river_lake_see
execute positioned ~ ~ ~-1 run function derailed:dev/gen/_river_lake_see
execute positioned ~ ~ ~1 run function derailed:dev/gen/_river_lake_see

# The seed is marked rather than the ground painted, since the kinds are not
#  rolled until after the river is cut and a reroll would draw over it
execute if score #lake_id dr_var matches 0.. as @e[type=marker,tag=dr_seed,distance=0..] if score @s dr_id = #lake_id dr_var run tag @s add dr_lake
execute if score #lake_id dr_var matches 0.. run scoreboard players add #riv_lakes dr_var 1

# Nothing the section grew itself meeting that corner leaves the river ending dry,
#  which is counted so that it is not mistaken for the lake never being looked for
# It counts what was there to draw from rather than what came out of the draw, so
#  a draw that somehow takes nothing does not read as nothing to take
execute if score #lake_n dr_var matches 0 run scoreboard players add #riv_dry dr_var 1
