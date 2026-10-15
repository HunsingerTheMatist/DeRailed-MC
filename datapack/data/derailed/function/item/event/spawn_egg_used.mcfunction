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
execute store result score #curr_rotation dr_arg run data get entity @s Rotation[0] 1

scoreboard players operation #curr_item_count dr_arg = @s dr_count

# Sneaking narrows the action to a single item
execute if predicate derailed:is_sneaking if score #curr_item_count dr_arg matches 2.. run scoreboard players set #curr_item_count dr_arg 1

# A rail clicked beside the end of the track is laid there, and put down as a
#  pile anywhere else
scoreboard players set #lay dr_temp 0
execute if score #curr_item dr_arg = $Rail dr_const at @n[type=marker,distance=..10,tag=dr_item,tag=dr_current] align xyz positioned ~0.5 ~ ~0.5 run function derailed:track/try_lay
execute if score #lay dr_temp matches 2 run function derailed:item/place_fail
execute if score #lay dr_temp matches 0 at @n[type=marker,distance=..10,tag=dr_item,tag=dr_current] align xyz positioned ~0.5 ~ ~0.5 run function derailed:item/try_place_clicked

kill @e[type=marker,distance=..10,tag=dr_item,tag=dr_current]
