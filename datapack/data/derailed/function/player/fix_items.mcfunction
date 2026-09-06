# Redraw the main hand so it matches the carried record. Run as the player
#
# The record is the source of truth and the held item is only a view of it, so
#  this clears first and mints the whole stack fresh

clear @s panda_spawn_egg
execute if score @s dr_count matches ..0 run return 0
execute if score @s dr_item matches ..0 run return run scoreboard players set @s dr_count 0

execute store result storage derailed:macro item int 1 run scoreboard players get @s dr_item
execute store result storage derailed:macro player_id int 1 run scoreboard players get @s dr_player_id
execute store result storage derailed:macro stack_size int 1 run scoreboard players get @s dr_count

execute if score @s dr_item = $Wood dr_const run data modify storage derailed:macro item_name set value "wood"
execute if score @s dr_item = $Iron dr_const run data modify storage derailed:macro item_name set value "iron"
execute if score @s dr_item = $Rail dr_const run data modify storage derailed:macro item_name set value "rail"
execute if score @s dr_item = $Bucket dr_const run data modify storage derailed:macro item_name set value "bucket"
execute if score @s dr_item matches 4 run data modify storage derailed:macro item_name set value "_small_wood"
execute if score @s dr_item matches 5 run data modify storage derailed:macro item_name set value "_small_iron"

data modify storage derailed:macro custom_model_data set value ""
execute if score @s dr_item = $Bucket dr_const if score #bucket_is_filled dr_var matches 1 run data modify storage derailed:macro custom_model_data set value "filled"

function derailed:player/_set_hand with storage derailed:macro
return 1
