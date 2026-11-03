# Takes wood or iron from the supply wagon into the player's empty hand, as
#  many as it holds or one when sneaking: whichever it holds, or with both, the
#  one of the half aimed at, wood at the front and iron at the back, and
#  nothing where the aim is not found to meet the wagon; refused when the
#  wagon has neither
# Run as the player

execute unless score $SupplyWood dr_var matches 1.. unless score $SupplyIron dr_var matches 1.. run return run function derailed:item/reject

scoreboard players set #curr_item dr_arg 0
execute unless score $SupplyIron dr_var matches 1.. run scoreboard players operation #curr_item dr_arg = $Wood dr_const
execute unless score $SupplyWood dr_var matches 1.. run scoreboard players operation #curr_item dr_arg = $Iron dr_const
scoreboard players set #ray_steps dr_temp 0
execute if score #curr_item dr_arg matches 0 at @s anchored eyes positioned ^ ^ ^ run function derailed:train/_supply_aim
execute if score #curr_item dr_arg matches 0 run return 0

execute if score #curr_item dr_arg = $Wood dr_const run scoreboard players operation #give_count dr_arg = $SupplyWood dr_var
execute if score #curr_item dr_arg = $Iron dr_const run scoreboard players operation #give_count dr_arg = $SupplyIron dr_var

scoreboard players operation #give_count dr_arg < $HandCap dr_config
execute if predicate derailed:is_sneaking run scoreboard players set #give_count dr_arg 1

execute if score #curr_item dr_arg = $Wood dr_const run scoreboard players operation $SupplyWood dr_var -= #give_count dr_arg
execute if score #curr_item dr_arg = $Iron dr_const run scoreboard players operation $SupplyIron dr_var -= #give_count dr_arg

# Held off topping up from it by auto pickup until they walk away from the
#  wagon
execute if score #curr_item dr_arg = $Wood dr_const run tag @s add dr_hold_wood
execute if score #curr_item dr_arg = $Iron dr_const run tag @s add dr_hold_iron

function derailed:item/give_item
function derailed:train/draw_loads
