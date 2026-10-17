# A placement or a thrown pile was right-clicked. Run as the player
#
# Right click is the only button that reaches a placement, because left click is
#  mining. An empty hand takes from it, anything else gives, and a resource
#  that none of would go on a pile of its own kind takes from it instead

#tellraw @a "HI"
#tellraw @a [{score:{name:"temp",objective:"dr_temp"}}]
advancement revoke @s only derailed:interaction_use

function derailed:item/_find_interaction with entity @s

scoreboard players operation #curr_player_id dr_arg = @s dr_player_id
scoreboard players operation #curr_item dr_arg = @s dr_item
execute store result score #curr_rotation dr_arg run data get entity @s Rotation[0] 1

execute at @n[type=interaction,distance=..10,tag=dr_water,tag=dr_current] run \
    return run function derailed:item/event/interacted_water
execute if entity @n[type=interaction,distance=..10,tag=dr_toss_box,tag=dr_current] run \
    return run function derailed:toss/catch

execute store success score #placement_found dr_temp run \
    data remove entity @n[type=interaction,distance=..10,tag=dr_placement,tag=dr_current] interaction
execute if score #placement_found dr_temp matches 0 run return fail

# Pickup if the player has an empty hand
execute if score @s dr_count matches 0 run \
    return run execute at @n[type=interaction,distance=..10,tag=dr_placement,tag=dr_current] run function derailed:item/pickup

# Otherwise give what is held to the placement
scoreboard players operation #curr_item_count dr_arg = @s dr_count

# Sneaking narrows the action to a single item
execute if predicate derailed:is_sneaking if score #curr_item_count dr_arg matches 2.. run scoreboard players set #curr_item_count dr_arg 1

scoreboard players set #swap_allowed dr_arg 1
# Prevent swapping if placing 1 out of 2+ items
execute if score #curr_item_count dr_arg matches 1 if score @s dr_count matches 2.. run scoreboard players set #swap_allowed dr_arg 0
execute at @n[type=interaction,distance=..10,tag=dr_placement,tag=dr_current] if function derailed:item/place_on_placement run return 1

# Where none would go on, a pile of the resource held is taken from instead,
#  while the hand has room
execute if score @s dr_item <= $LastResource dr_const if score @s dr_count < $HandCap dr_config \
    if score @n[type=interaction,distance=..10,tag=dr_placement,tag=dr_current] dr_item = @s dr_item run \
    return run execute at @n[type=interaction,distance=..10,tag=dr_placement,tag=dr_current] run function derailed:item/pickup
function derailed:item/place_fail
