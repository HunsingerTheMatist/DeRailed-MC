
# Moves this player out of every train shulker's box they stand in, just past
#  the side of it they are nearest, since a box moving into a player leaves
#  them inside it, then out from under the barriers over the train's rails
# Run as the player, at them

execute store result score #px dr_temp run data get entity @s Pos[0] 1000
execute store result score #py dr_temp run data get entity @s Pos[1] 1000
execute store result score #pz dr_temp run data get entity @s Pos[2] 1000
scoreboard players set #pushed dr_temp 0
execute as @e[type=item_display,tag=dr_train_box,distance=..3] run function derailed:train/_push_from
execute if score #pushed dr_temp matches 1 run function derailed:train/_push_to
execute at @s run function derailed:train/_push_pane
