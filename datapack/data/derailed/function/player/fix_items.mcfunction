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

execute if score @s dr_item = $Wood dr_const run data modify storage derailed:macro item_model set value "derailed:wood"
execute if score @s dr_item = $Iron dr_const run data modify storage derailed:macro item_model set value "derailed:iron"
execute if score @s dr_item = $Rail dr_const run data modify storage derailed:macro item_model set value "derailed:rail"
execute if score @s dr_item = $Axe dr_const run data modify storage derailed:macro item_model set value "minecraft:stone_axe"
execute if score @s dr_item = $Pickaxe dr_const run data modify storage derailed:macro item_model set value "minecraft:stone_pickaxe"
execute if score @s dr_item = $Bucket dr_const run data modify storage derailed:macro item_model set value "derailed:bucket"

execute if score @s dr_item = $Wood dr_const run data modify storage derailed:macro item_name set value "Wood"
execute if score @s dr_item = $Iron dr_const run data modify storage derailed:macro item_name set value "Iron"
execute if score @s dr_item = $Rail dr_const run data modify storage derailed:macro item_name set value "Rail"
execute if score @s dr_item = $Axe dr_const run data modify storage derailed:macro item_name set value "Stone Axe"
execute if score @s dr_item = $Pickaxe dr_const run data modify storage derailed:macro item_name set value "Stone Pickaxe"
execute if score @s dr_item = $Bucket dr_const run data modify storage derailed:macro item_name set value "Bucket"

#give @a acacia_boat[tool={default_mining_speed:0,rules:[{blocks:'#leaves',speed:0.48,correct_for_drops:true},{blocks:'#derailed:glass',speed:0.7,correct_for_drops:true}]},attribute_modifiers=[{type:block_break_speed,id:can_mine,slot:mainhand,amount:1,operation:add_value}]]
#give @a acacia_boat[tool={default_mining_speed:0,rules:[{blocks:'#derailed:stone/mineable_glass',speed:0.3,correct_for_drops:true},{blocks:'iron_ore',speed:2.3,correct_for_drops:true}]},attribute_modifiers=[{type:block_break_speed,id:can_mine,slot:mainhand,amount:1,operation:add_value}]]
data modify storage derailed:macro extra_components set value ""
execute if score @s dr_item = $Axe dr_const run \
    data modify storage derailed:macro extra_components set value ",tool={default_mining_speed:0,rules:[{blocks:'#derailed:tree/mineable_glass',speed:0.7,correct_for_drops:true},{blocks:'#derailed:tree/mineable_leaves',speed:0.47,correct_for_drops:true}]},attribute_modifiers=[{type:block_break_speed,id:can_mine,slot:mainhand,amount:1,operation:add_value}]"
execute if score @s dr_item = $Pickaxe dr_const run \
    data modify storage derailed:macro extra_components set value ",tool={default_mining_speed:0,rules:[{blocks:'#derailed:stone/mineable_copper',speed:7,correct_for_drops:true}]},attribute_modifiers=[{type:block_break_speed,id:can_mine,slot:mainhand,amount:1,operation:add_value}]"
execute if score @s dr_item = $Bucket dr_const if score #bucket_is_filled dr_var matches 1 run \
    data modify storage derailed:macro extra_components set value ",custom_model_data={strings:[filled]}"

function derailed:player/_set_hand with storage derailed:macro
return 1
