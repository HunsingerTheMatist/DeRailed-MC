# Puts the wood or iron in the player's hand into the supply wagon, as many as
#  there is room for, '$SupplyCap' of each, or one when sneaking; refused when
#  the wagon is full of it
# Run as the player

scoreboard players operation #curr_item dr_arg = @s dr_item
scoreboard players operation #curr_item_count dr_arg = $SupplyCap dr_config
execute if score #curr_item dr_arg = $Wood dr_const run scoreboard players operation #curr_item_count dr_arg -= $SupplyWood dr_var
execute if score #curr_item dr_arg = $Iron dr_const run scoreboard players operation #curr_item_count dr_arg -= $SupplyIron dr_var
execute if score #curr_item_count dr_arg matches ..0 run return run function derailed:item/reject

scoreboard players operation #curr_item_count dr_arg < @s dr_count
execute if predicate derailed:is_sneaking run scoreboard players set #curr_item_count dr_arg 1

execute if score #curr_item dr_arg = $Wood dr_const run scoreboard players operation $SupplyWood dr_var += #curr_item_count dr_arg
execute if score #curr_item dr_arg = $Iron dr_const run scoreboard players operation $SupplyIron dr_var += #curr_item_count dr_arg

# Held off taking it back by auto pickup until they walk away from the wagon
execute if score #curr_item dr_arg = $Wood dr_const run tag @s add dr_hold_wood
execute if score #curr_item dr_arg = $Iron dr_const run tag @s add dr_hold_iron

function derailed:player/take_items
function derailed:train/draw_loads
