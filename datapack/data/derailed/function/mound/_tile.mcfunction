
# Builds this tile's nine columns from the heights of its four corners, on two
#  blocks below the ground, polished andesite under iron and deepslate under
#  rock
# Run as the tile's marker, at it, with its corners a layer above: its own
#  place, and one east, one south and one southeast of it

execute positioned ~ ~1 ~ as @e[type=marker,tag=dr_mound_c,distance=..0.5] run scoreboard players operation #h00 dr_temp = @s dr_mh
execute positioned ~1 ~1 ~ as @e[type=marker,tag=dr_mound_c,distance=..0.5] run scoreboard players operation #h10 dr_temp = @s dr_mh
execute positioned ~ ~1 ~1 as @e[type=marker,tag=dr_mound_c,distance=..0.5] run scoreboard players operation #h01 dr_temp = @s dr_mh
execute positioned ~1 ~1 ~1 as @e[type=marker,tag=dr_mound_c,distance=..0.5] run scoreboard players operation #h11 dr_temp = @s dr_mh

# The nudge all nine columns share, into '#mtj', and which corner's two by two
#  columns spike, into '#msq', -1 for none
scoreboard players operation #mv dr_temp = #mtjit dr_temp
function derailed:mound/_nudge
scoreboard players operation #mtj dr_temp = #mj dr_temp
scoreboard players set #msq dr_temp -1
scoreboard players set #mlo dr_temp 1
scoreboard players set #mhi dr_temp 100
function derailed:mound/_rand
scoreboard players set #mlo dr_temp 0
scoreboard players set #mhi dr_temp 3
execute if score #mj dr_temp <= #mspk dr_temp store result score #msq dr_temp run function derailed:mound/_rand

# The tile's northwestern block on the ground
scoreboard players operation #mt dr_temp = @s dr_mx
scoreboard players operation #mt dr_temp *= #m3 dr_temp
execute store result entity @n[type=marker,tag=dr_mound_at,distance=0..] Pos[0] double 1 run scoreboard players operation #mt dr_temp += #mound_dx dr_arg
execute store result entity @n[type=marker,tag=dr_mound_at,distance=0..] Pos[1] double 1 run scoreboard players get #mound_dy dr_arg
scoreboard players operation #mt dr_temp = @s dr_mz
scoreboard players operation #mt dr_temp *= #m3 dr_temp
execute store result entity @n[type=marker,tag=dr_mound_at,distance=0..] Pos[2] double 1 run scoreboard players operation #mt dr_temp += #mound_dz dr_arg

execute if score #mound_kind dr_arg matches 0 at @n[type=marker,tag=dr_mound_at,distance=0..] run fill ~ ~-2 ~ ~2 ~-1 ~2 polished_andesite strict
execute if score #mound_kind dr_arg matches 1 at @n[type=marker,tag=dr_mound_at,distance=0..] run fill ~ ~-2 ~ ~2 ~-1 ~2 deepslate[axis=y] strict
execute at @n[type=marker,tag=dr_mound_at,distance=0..] run function derailed:mound/_blocks
