# Moves the crafting wagon on a tick: while the supply wagon holds a wood and
#  an iron and the crafting wagon has room for another rail, a rail is made
#  every '$CraftTicks', taking the wood and the iron as it joins the rails; a
#  rail being made stops when either runs out
# Run in the game's dimension

scoreboard players set #can_craft dr_temp 0
execute if score $Rails dr_var < $RailCap dr_config if score $SupplyWood dr_var matches 1.. if score $SupplyIron dr_var matches 1.. run scoreboard players set #can_craft dr_temp 1
execute if score #can_craft dr_temp matches 0 run return run scoreboard players set $CraftLeft dr_var 0

execute if score $CraftLeft dr_var matches 0 run scoreboard players operation $CraftLeft dr_var = $CraftTicks dr_config
scoreboard players remove $CraftLeft dr_var 1
execute if score $CraftLeft dr_var matches 1.. run return 0

scoreboard players remove $SupplyWood dr_var 1
scoreboard players remove $SupplyIron dr_var 1
scoreboard players add $Rails dr_var 1
execute at @e[type=item_display,tag=dr_train_crafting,distance=0..] run playsound minecraft:block.smithing_table.use block @a ~ ~1 ~ 0.6
function derailed:train/draw_loads
