# Hands the click on a piece of the train to the wagon clicked, the supply
#  wagon or the crafting wagon; the others refuse it
# Run as the player

data remove entity @n[type=interaction,distance=..10,tag=dr_train_click,tag=dr_current] interaction

scoreboard players set #train_click dr_temp 0
execute as @n[type=interaction,distance=..10,tag=dr_train_click,tag=dr_current] on vehicle if entity @s[tag=dr_train_supply] run scoreboard players set #train_click dr_temp 1
execute as @n[type=interaction,distance=..10,tag=dr_train_click,tag=dr_current] on vehicle if entity @s[tag=dr_train_crafting] run scoreboard players set #train_click dr_temp 2
execute if score #train_click dr_temp matches 1 run return run function derailed:train/supply_click
execute if score #train_click dr_temp matches 2 run return run function derailed:train/crafting_click
function derailed:item/reject
