# Start a new placement on this tile holding #curr_item_count of #curr_item
# Run as the player, at the tile

tellraw @a "Placing new stack"
function derailed:item/new_placement
scoreboard players operation @n[type=interaction,distance=..0.5,tag=dr_placement] dr_item = #curr_item dr_arg
scoreboard players operation @n[type=interaction,distance=..0.5,tag=dr_placement] dr_count = #curr_item_count dr_arg

# The placement starts facing the direction of the player, snapped to 90 degree steps
# Biasing by 45 rounds to the nearest step; the extra 360 keeps the divide
#  positive, so negative yaw snaps the same way as positive
execute store result score #rotation dr_temp run data get entity @s Rotation[0] 1
scoreboard players add #rotation dr_temp 405
scoreboard players operation #rotation dr_temp /= $RotationStep dr_const
scoreboard players operation #rotation dr_temp *= $RotationStep dr_const
execute store result entity @n[type=interaction,distance=..0.5,tag=dr_placement] Rotation[0] float 1 run scoreboard players remove #rotation dr_temp 360

execute as @n[type=interaction,distance=..0.5,tag=dr_placement] at @s run function derailed:placement/update_placement

function derailed:player/take_items
return 1
