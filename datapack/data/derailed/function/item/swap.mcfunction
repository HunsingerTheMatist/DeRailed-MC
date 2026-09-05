
tellraw @a "Doing Swap"
# Store the information about the existing resource
scoreboard players operation #swap_resource dr_arg = @n[type=interaction,distance=..0.5,tag=dr_resource] dr_resource
scoreboard players operation #give_count dr_arg = @n[type=interaction,distance=..0.5,tag=dr_resource] dr_count

kill @e[type=interaction,distance=..0.5,tag=dr_resource]
kill @e[type=item_display,distance=..0.5,tag=dr_resource]

function derailed:item/place_new

scoreboard players operation #curr_resource dr_arg = #swap_resource dr_arg
function derailed:item/give_resource

return 1
