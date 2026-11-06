# Tops up a partly full hand from a wagon of the player's team's train they
#  stand against, not burning: wood or iron from the supply wagon and rails
#  from the crafting wagon, unless the player is held off that resource
# Standing against is touching the wagon's interaction with a box 2.5 blocks
#  across and a block tall from 3 pixels over the feet
# Run as the player, at the player

scoreboard players operation #team dr_temp = @s dr_team
tag @e[type=item_display,tag=dr_train_touched,distance=..5] remove dr_train_touched
execute positioned ~-1.25 ~0.1875 ~-1.25 as @e[type=interaction,tag=dr_train_click,dx=1.5,dy=0,dz=1.5] if score @s dr_team = #team dr_temp on vehicle if entity @s[tag=!dr_burning] run tag @s add dr_train_touched

scoreboard players set #give_count dr_arg 0
execute if score @s dr_item = $Wood dr_const unless entity @s[tag=dr_hold_wood] run scoreboard players operation #give_count dr_arg = @n[type=item_display,tag=dr_train_supply,tag=dr_train_touched,distance=..5] dr_wood
execute if score @s dr_item = $Iron dr_const unless entity @s[tag=dr_hold_iron] run scoreboard players operation #give_count dr_arg = @n[type=item_display,tag=dr_train_supply,tag=dr_train_touched,distance=..5] dr_iron
execute if score @s dr_item = $Rail dr_const unless entity @s[tag=dr_hold_rail] run scoreboard players operation #give_count dr_arg = @n[type=item_display,tag=dr_train_crafting,tag=dr_train_touched,distance=..5] dr_rails

scoreboard players operation #room dr_temp = $HandCap dr_config
scoreboard players operation #room dr_temp -= @s dr_count
scoreboard players operation #give_count dr_arg < #room dr_temp
execute if score #give_count dr_arg matches ..0 run return fail

execute if score @s dr_item = $Wood dr_const run scoreboard players operation @n[type=item_display,tag=dr_train_supply,tag=dr_train_touched,distance=..5] dr_wood -= #give_count dr_arg
execute if score @s dr_item = $Iron dr_const run scoreboard players operation @n[type=item_display,tag=dr_train_supply,tag=dr_train_touched,distance=..5] dr_iron -= #give_count dr_arg
execute if score @s dr_item = $Rail dr_const run scoreboard players operation @n[type=item_display,tag=dr_train_crafting,tag=dr_train_touched,distance=..5] dr_rails -= #give_count dr_arg
scoreboard players operation #curr_item dr_arg = @s dr_item
function derailed:item/give_item
execute if score @s dr_item = $Rail dr_const as @n[type=item_display,tag=dr_train_crafting,tag=dr_train_touched,distance=..5] run function derailed:train/draw_loads
execute unless score @s dr_item = $Rail dr_const as @n[type=item_display,tag=dr_train_supply,tag=dr_train_touched,distance=..5] run function derailed:train/draw_loads
