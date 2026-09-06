# Add #curr_item_count to the placement already on this tile
# Run at the tile

tellraw @a "Adding to existing stack"
scoreboard players operation @n[type=interaction,distance=..0.5,tag=dr_placement] dr_count += #curr_item_count dr_arg

execute as @n[type=interaction,distance=..0.5,tag=dr_placement] at @s run function derailed:placement/update_placement

function derailed:player/take_items
return 1
