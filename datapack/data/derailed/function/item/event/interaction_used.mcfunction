# A resource pile was right-clicked. Run as the player
#
# Right click is the only button that reaches a pile, because left click is
#  mining. Direction is decided by whether the pile can be taken from: room in
#  hand for a resource already held (or an empty hand) takes, anything else
#  gives

#tellraw @a "HI"
#tellraw @a [{score:{name:"temp",objective:"dr_temp"}}]
advancement revoke @s only derailed:interaction_use

function derailed:item/_find_interaction with entity @s

scoreboard players operation #curr_player_id dr_arg = @s dr_player_id
scoreboard players operation #curr_resource dr_arg = @s dr_resource

execute at @n[type=interaction,distance=..10,tag=dr_water,tag=dr_current] run \
    return run function derailed:item/event/interacted_water

execute store success score #pile_found dr_temp run \
    data remove entity @n[type=interaction,distance=..10,tag=dr_resource,tag=dr_current] interaction
execute if score #pile_found dr_temp matches 0 run return fail

# Taking needs both room in hand and a resource that can go there. An empty hand
#  takes anything; a full hand takes nothing and gives instead
scoreboard players set #can_take dr_temp 0
execute if score @s dr_count matches 0 run scoreboard players set #can_take dr_temp 1
execute if score @s dr_resource = @n[type=interaction,distance=..10,tag=dr_resource,tag=dr_current] dr_resource run scoreboard players set #can_take dr_temp 1
execute if score @s dr_count >= $HandCap dr_config run scoreboard players set #can_take dr_temp 0

execute if score #can_take dr_temp matches 1 run return run execute at @n[type=interaction,distance=..10,tag=dr_resource,tag=dr_current] run function derailed:item/pickup

# Otherwise give what is held to the pile
scoreboard players operation #curr_resource_count dr_arg = @s dr_count

# Sneaking narrows the action to a single resource
execute if predicate derailed:is_sneaking if score #curr_resource_count dr_arg matches 2.. run scoreboard players set #curr_resource_count dr_arg 1

scoreboard players set #swap_allowed dr_arg 1
# Prevent swapping if placing 1 out of 2+ resources
execute if score #curr_resource_count dr_arg matches 1 if score @s dr_count matches 2.. run scoreboard players set #swap_allowed dr_arg 0
execute at @n[type=interaction,distance=..10,tag=dr_resource,tag=dr_current] align xyz positioned ~0.5 ~ ~0.5 run function derailed:item/try_place
