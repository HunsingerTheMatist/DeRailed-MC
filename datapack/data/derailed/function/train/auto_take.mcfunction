# Tops up a partly full hand from a wagon of the train the player stands
#  against: wood or iron from the supply wagon and rails from the crafting
#  wagon, unless the player is held off that resource
# Standing against is touching the wagon's interaction with a box 2.5 blocks
#  across and a block tall from 3 pixels over the feet
# Run as the player, at the player

execute positioned ~-1.25 ~0.1875 ~-1.25 as @e[type=interaction,tag=dr_train_click,dx=1.5,dy=0,dz=1.5] on vehicle run tag @s add dr_train_touched

scoreboard players set #give_count dr_arg 0
execute if score @s dr_item = $Wood dr_const unless entity @s[tag=dr_hold_wood] if entity @e[type=item_display,tag=dr_train_supply,tag=dr_train_touched,distance=..5] run scoreboard players operation #give_count dr_arg = $SupplyWood dr_var
execute if score @s dr_item = $Iron dr_const unless entity @s[tag=dr_hold_iron] if entity @e[type=item_display,tag=dr_train_supply,tag=dr_train_touched,distance=..5] run scoreboard players operation #give_count dr_arg = $SupplyIron dr_var
execute if score @s dr_item = $Rail dr_const unless entity @s[tag=dr_hold_rail] if entity @e[type=item_display,tag=dr_train_crafting,tag=dr_train_touched,distance=..5] run scoreboard players operation #give_count dr_arg = $Rails dr_var
tag @e[type=item_display,tag=dr_train_touched,distance=..5] remove dr_train_touched

scoreboard players operation #room dr_temp = $HandCap dr_config
scoreboard players operation #room dr_temp -= @s dr_count
scoreboard players operation #give_count dr_arg < #room dr_temp
execute if score #give_count dr_arg matches ..0 run return fail

execute if score @s dr_item = $Wood dr_const run scoreboard players operation $SupplyWood dr_var -= #give_count dr_arg
execute if score @s dr_item = $Iron dr_const run scoreboard players operation $SupplyIron dr_var -= #give_count dr_arg
execute if score @s dr_item = $Rail dr_const run scoreboard players operation $Rails dr_var -= #give_count dr_arg
scoreboard players operation #curr_item dr_arg = @s dr_item
function derailed:item/give_item
function derailed:train/draw_loads
