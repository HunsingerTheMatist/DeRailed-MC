# Takes the rails of the crafting wagon clicked into the player's hand, empty or
#  holding rails, as many as it has room for or one when sneaking; refused when
#  the hand holds anything else, is full or the wagon has none
# Run as the player

execute if score @s dr_count matches 1.. unless score @s dr_item = $Rail dr_const run return run function derailed:item/reject

scoreboard players operation #give_count dr_arg = $HandCap dr_config
scoreboard players operation #give_count dr_arg -= @s dr_count
scoreboard players operation #give_count dr_arg < @n[type=item_display,tag=dr_wagon_clicked,distance=..10] dr_rails
execute if score #give_count dr_arg matches ..0 run return run function derailed:item/reject
execute if predicate derailed:is_sneaking run scoreboard players set #give_count dr_arg 1

scoreboard players operation @n[type=item_display,tag=dr_wagon_clicked,distance=..10] dr_rails -= #give_count dr_arg

# Held off topping up from it by auto pickup until they walk away from the
#  wagon
tag @s add dr_hold_rail

scoreboard players operation #curr_item dr_arg = $Rail dr_const
function derailed:item/give_item
execute as @n[type=item_display,tag=dr_wagon_clicked,distance=..10] run function derailed:train/draw_loads
