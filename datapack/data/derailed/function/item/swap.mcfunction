
tellraw @a "Doing Swap"
# Store the information about the existing item
scoreboard players operation #swap_item dr_arg = @n[type=interaction,distance=..0.5,tag=dr_placement] dr_item
scoreboard players operation #give_count dr_arg = @n[type=interaction,distance=..0.5,tag=dr_placement] dr_count

kill @e[type=interaction,distance=..0.5,tag=dr_placement]
kill @e[type=item_display,distance=..0.5,tag=dr_placement]

function derailed:item/place_new

scoreboard players operation #curr_item dr_arg = #swap_item dr_arg
function derailed:item/give_item

return 1
