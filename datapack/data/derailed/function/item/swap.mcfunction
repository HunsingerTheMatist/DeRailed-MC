# Swaps #curr_item_count of #curr_item for the placement here, where all of
#  them fit where it stands
# Run as the player, at the placement's interaction entity
#
# Returns 1 when swapped, fail otherwise

scoreboard players operation #want_count dr_temp = #curr_item_count dr_arg
function derailed:item/_room_here
execute if score #curr_item dr_arg <= $LastResource dr_const run function derailed:item/_fit
execute if score #curr_item dr_arg <= $LastResource dr_const if score #fit dr_temp < #curr_item_count dr_arg run return fail
execute if score #curr_item dr_arg = $Bucket dr_const if score #room dr_temp matches ..9999 run return fail

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
