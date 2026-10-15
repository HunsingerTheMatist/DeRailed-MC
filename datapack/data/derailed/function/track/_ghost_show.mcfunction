# Keeps the ghost rail on this tile, or puts one there, where the rail laid here
#  would stand on open ground: its edge, middle and far edge, and the end's edge
#  a block before them where the end's rail would turn
# Run as the marker of a tile the next rail could go on, at it, facing the way
#  on to it

execute store result score #din dr_temp run data get storage derailed:train path[-1].din
execute store result score #d dr_temp run data get entity @s Rotation[0]
scoreboard players operation #d dr_temp /= $RotationStep dr_const
scoreboard players add #d dr_temp 2
scoreboard players operation #d dr_temp %= $Four dr_const
scoreboard players set #curve dr_temp 0
execute unless score #d dr_temp = #din dr_temp run scoreboard players set #curve dr_temp 1
execute positioned ^ ^ ^-1 unless function derailed:track/_open run return 0
execute unless function derailed:track/_open run return 0
execute positioned ^ ^ ^1 unless function derailed:track/_open run return 0
execute if score #curve dr_temp matches 1 positioned ^ ^ ^-2 unless function derailed:track/_open run return 0

execute if entity @e[type=item_display,tag=dr_rail_ghost,distance=..0.01] run \
    return run tag @e[type=item_display,tag=dr_rail_ghost,distance=..0.01] remove dr_ghost_stale
summon item_display ~ ~ ~ {Tags:["dr_rail_ghost"],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:rail_ghost"}}}
data modify entity @n[type=item_display,tag=dr_rail_ghost,distance=..0.01] Rotation set from entity @s Rotation
