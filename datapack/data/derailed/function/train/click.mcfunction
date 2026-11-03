# Hands the click on a piece of the train to the wagon clicked, tagged
#  'dr_wagon_clicked', the supply wagon or the crafting wagon; the others
#  refuse it, and another team's train, or any for a player on no team, takes
#  no notice of it at all
# Run as the player

data remove entity @n[type=interaction,distance=..10,tag=dr_train_click,tag=dr_current] interaction

scoreboard players operation #team dr_temp = @s dr_team
execute unless score @n[type=interaction,distance=..10,tag=dr_train_click,tag=dr_current] dr_team = #team dr_temp run return 0

tag @e[type=item_display,tag=dr_wagon_clicked,distance=0..] remove dr_wagon_clicked
execute as @n[type=interaction,distance=..10,tag=dr_train_click,tag=dr_current] on vehicle run tag @s add dr_wagon_clicked
execute if entity @e[type=item_display,tag=dr_wagon_clicked,tag=dr_train_supply,distance=..10] run return run function derailed:train/supply_click
execute if entity @e[type=item_display,tag=dr_wagon_clicked,tag=dr_train_crafting,distance=..10] run return run function derailed:train/crafting_click
function derailed:item/reject
