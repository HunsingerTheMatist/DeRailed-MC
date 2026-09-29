
# Clears this tile of iron's three by three blocks and builds its nine columns
#  from the heights of its four corners
# Run as the tile's marker, at it, with its corners a layer above: its own
#  place, and one east, one south and one southeast of it

execute positioned ~ ~1 ~ as @e[type=marker,tag=dr_mc,distance=..0.5] run scoreboard players operation #h00 dr_var = @s dr_mh
execute positioned ~1 ~1 ~ as @e[type=marker,tag=dr_mc,distance=..0.5] run scoreboard players operation #h10 dr_var = @s dr_mh
execute positioned ~ ~1 ~1 as @e[type=marker,tag=dr_mc,distance=..0.5] run scoreboard players operation #h01 dr_var = @s dr_mh
execute positioned ~1 ~1 ~1 as @e[type=marker,tag=dr_mc,distance=..0.5] run scoreboard players operation #h11 dr_var = @s dr_mh

# The nudge all nine columns share, into '#mtj', and which corner's two by two
#  columns spike, into '#msq', -1 for none
data modify storage derailed:mound r.v set from storage derailed:mound cfg.tjit
function derailed:dev/mound/_nudge with storage derailed:mound r
scoreboard players operation #mtj dr_var = #mj dr_var
scoreboard players set #msq dr_var -1
execute store result score #mj dr_var run random value 1..100
execute if score #mj dr_var <= #mspk dr_var store result score #msq dr_var run random value 0..3

scoreboard players operation #mt dr_var = @s dr_mx
scoreboard players operation #mt dr_var *= #m3 dr_var
execute store result storage derailed:mound t.x int 1 run scoreboard players operation #mt dr_var += #mdx dr_var
execute store result storage derailed:mound t.y int 1 run scoreboard players get #mdy dr_var
scoreboard players operation #mt dr_var = @s dr_mz
scoreboard players operation #mt dr_var *= #m3 dr_var
execute store result storage derailed:mound t.z int 1 run scoreboard players operation #mt dr_var += #mdz dr_var
function derailed:dev/mound/_tile_at with storage derailed:mound t
