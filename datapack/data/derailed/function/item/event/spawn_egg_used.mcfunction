# Fires while a item is being used. Run as the player
#
# Use triggers fire EVERY TICK the button is held, so this whole function runs
#  continuously during a hold. It refreshes dr_use_cd on each of those ticks,
#  which stops the cooldown ever reaching zero - so the press body below only
#  runs on the first tick. Releasing lets the cooldown expire, which re-arms it
#  and calls on_release

advancement revoke @s only derailed:spawn_egg_use

execute as @e[type=marker,distance=..10,tag=dr_item,tag=!dr_init] run function derailed:item/init_marker

scoreboard players operation #curr_player_id dr_arg = @s dr_player_id
tag @e[type=marker,distance=..10,tag=dr_item] remove dr_current
execute as @e[type=marker,distance=..10,tag=dr_item] if score @s dr_player_id = #curr_player_id dr_arg run tag @s add dr_current
scoreboard players operation #curr_item dr_arg = @s dr_item

scoreboard players operation #curr_item_count dr_arg = @s dr_count

# Sneaking narrows the action to a single item
execute if predicate derailed:is_sneaking if score #curr_item_count dr_arg matches 2.. run scoreboard players set #curr_item_count dr_arg 1

scoreboard players set #swap_allowed dr_arg 1
# Prevent swapping if placing 1 out of 2+ items
execute if score #curr_item_count dr_arg matches 1 if score @s dr_count matches 2.. run scoreboard players set #swap_allowed dr_arg 0
execute at @n[type=marker,distance=..10,tag=dr_item,tag=dr_current] align xyz positioned ~0.5 ~ ~0.5 run function derailed:item/try_place

kill @e[type=marker,distance=..10,tag=dr_item,tag=dr_current]
