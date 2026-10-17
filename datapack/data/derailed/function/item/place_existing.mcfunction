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

# As many as fit where nothing stands in the way of the bigger pile, someone
#  standing on it included
scoreboard players operation #want_count dr_temp = #curr_item_count dr_arg
execute if score #curr_item dr_arg <= $LastResource dr_const run scoreboard players operation #want_count dr_temp < #fit dr_temp
scoreboard players operation #want_count dr_temp += @n[type=interaction,distance=..0.5,tag=dr_placement] dr_count
scoreboard players operation #want_min dr_temp = @n[type=interaction,distance=..0.5,tag=dr_placement] dr_count
scoreboard players add #want_min dr_temp 1
scoreboard players set #hit_base dr_temp 0
execute if score #curr_item dr_arg <= $LastResource dr_const unless function derailed:item/_fit_entities run return fail
execute if score #curr_item dr_arg <= $LastResource dr_const run scoreboard players operation #curr_item_count dr_arg = #want_count dr_temp
execute if score #curr_item dr_arg <= $LastResource dr_const run scoreboard players operation #curr_item_count dr_arg -= @n[type=interaction,distance=..0.5,tag=dr_placement] dr_count

tellraw @a "Adding to existing stack"
scoreboard players operation @n[type=interaction,distance=..0.5,tag=dr_placement] dr_count += #curr_item_count dr_arg

# While piles are moved aside for a rail the count is only noted, not yet drawn
#  and taking nothing off anyone
execute if score #shifting dr_temp matches 1 summon marker run function derailed:track/_shift_mark
execute if score #shifting dr_temp matches 1 run return 1

execute as @n[type=interaction,distance=..0.5,tag=dr_placement] at @s run function derailed:placement/update_placement

# Held for the player who added to it, or threw what was added, so auto pickup
#  leaves it to them until they are 3 blocks away
execute if score @s dr_player_id matches 1.. run tag @n[type=interaction,distance=..0.5,tag=dr_placement] add dr_held
execute if score @s dr_player_id matches 1.. run scoreboard players operation @n[type=interaction,distance=..0.5,tag=dr_placement] dr_player_id = @s dr_player_id

function derailed:player/take_items
return 1
