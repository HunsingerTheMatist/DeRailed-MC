# Take #curr_resource_count resources off the player. Run as the player
#
# Called once an action has actually consumed them, so the record only moves
#  when something happened. Carrying nothing left also clears the type

scoreboard players operation @s dr_count -= #curr_resource_count dr_arg
execute if score @s dr_count matches ..0 run scoreboard players set @s dr_resource 0
function derailed:player/fix_resources
