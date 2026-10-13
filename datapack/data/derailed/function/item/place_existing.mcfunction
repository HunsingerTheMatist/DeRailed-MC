# Add #curr_item_count to the placement already here, or as many of them as
#  there is room for over a pile
# Run as the player, at the placement's interaction entity
#
# Returns 1 when any items were placed, fail otherwise

scoreboard players operation #want_count dr_temp = #curr_item_count dr_arg
scoreboard players operation #want_count dr_temp += @n[type=interaction,distance=..0.5,tag=dr_placement] dr_count
execute if score #curr_item dr_arg <= $LastResource dr_const run function derailed:item/_room_here
execute if score #curr_item dr_arg <= $LastResource dr_const run function derailed:item/_fit
execute if score #curr_item dr_arg <= $LastResource dr_const run scoreboard players operation #fit dr_temp -= @n[type=interaction,distance=..0.5,tag=dr_placement] dr_count
execute if score #curr_item dr_arg <= $LastResource dr_const if score #fit dr_temp matches ..0 run return fail
execute if score #curr_item dr_arg <= $LastResource dr_const run scoreboard players operation #curr_item_count dr_arg < #fit dr_temp

tellraw @a "Adding to existing stack"
scoreboard players operation @n[type=interaction,distance=..0.5,tag=dr_placement] dr_count += #curr_item_count dr_arg

execute as @n[type=interaction,distance=..0.5,tag=dr_placement] at @s run function derailed:placement/update_placement

function derailed:player/take_items
return 1
