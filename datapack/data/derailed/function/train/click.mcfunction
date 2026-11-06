# Hands the click on a piece of the train to the piece clicked, tagged
#  'dr_wagon_clicked', the engine for a box its shulkers ride: a full bucket
#  goes to putting fires out, a burning piece refuses anything else, and
#  otherwise the supply wagon and the crafting wagon take it and the others
#  refuse it; another team's train, or any for a player on no team, takes no
#  notice of it at all
# Run as the player

data remove entity @n[type=interaction,distance=..10,tag=dr_train_click,tag=dr_current] interaction

scoreboard players operation #team dr_temp = @s dr_team
execute unless score @n[type=interaction,distance=..10,tag=dr_train_click,tag=dr_current] dr_team = #team dr_temp run return 0

tag @e[type=item_display,tag=dr_wagon_clicked,distance=0..] remove dr_wagon_clicked
execute as @n[type=interaction,distance=..10,tag=dr_train_click,tag=dr_current] on vehicle run tag @s add dr_wagon_clicked
scoreboard players set #tid dr_temp -1
execute as @e[type=item_display,tag=dr_wagon_clicked,tag=dr_train_carrier,distance=..10] run scoreboard players operation #tid dr_temp = @s dr_tid
execute as @e[type=item_display,tag=dr_train_engine,distance=0..] if score @s dr_tid = #tid dr_temp run tag @s add dr_wagon_clicked
tag @e[type=item_display,tag=dr_wagon_clicked,tag=dr_train_carrier,distance=..10] remove dr_wagon_clicked

execute if score @s dr_item = $BucketFull dr_const run return run function derailed:train/douse
execute if entity @e[type=item_display,tag=dr_wagon_clicked,tag=dr_burning,distance=0..] run return run function derailed:item/reject
execute if entity @e[type=item_display,tag=dr_wagon_clicked,tag=dr_train_supply,distance=..10] run return run function derailed:train/supply_click
execute if entity @e[type=item_display,tag=dr_wagon_clicked,tag=dr_train_crafting,distance=..10] run return run function derailed:train/crafting_click
function derailed:item/reject
