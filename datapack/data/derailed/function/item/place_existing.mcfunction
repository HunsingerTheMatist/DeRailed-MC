# Add #curr_resource_count to the pile already on this tile
# Run at the tile

tellraw @a "Adding to existing stack"
scoreboard players operation @n[type=interaction,distance=..0.5,tag=dr_resource] dr_count += #curr_resource_count dr_arg

execute as @n[type=interaction,distance=..0.5,tag=dr_resource] at @s run function derailed:resource/update_resource

function derailed:player/take_resources
return 1
