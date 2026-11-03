# Moves this crafting wagon on a tick: while its team's supply wagon holds a
#  wood and an iron and it has room for another rail, it makes a rail every
#  '$CraftTicks', taking the wood and the iron as the rail joins its rails; a
#  rail being made stops when either runs out
# Run as the crafting wagon's item display, at it

scoreboard players operation #team dr_temp = @s dr_team
tag @e[type=item_display,tag=dr_craft_from,distance=0..] remove dr_craft_from
execute as @e[type=item_display,tag=dr_train_supply,distance=0..] if score @s dr_team = #team dr_temp run tag @s add dr_craft_from

scoreboard players set #can_craft dr_temp 0
execute if score @s dr_rails < $RailCap dr_config if score @n[type=item_display,tag=dr_craft_from,distance=0..] dr_wood matches 1.. if score @n[type=item_display,tag=dr_craft_from,distance=0..] dr_iron matches 1.. run scoreboard players set #can_craft dr_temp 1
execute if score #can_craft dr_temp matches 0 run return run scoreboard players set @s dr_craft_left 0

execute if score @s dr_craft_left matches 0 run scoreboard players operation @s dr_craft_left = $CraftTicks dr_config
scoreboard players remove @s dr_craft_left 1
execute if score @s dr_craft_left matches 1.. run return 0

scoreboard players remove @n[type=item_display,tag=dr_craft_from,distance=0..] dr_wood 1
scoreboard players remove @n[type=item_display,tag=dr_craft_from,distance=0..] dr_iron 1
scoreboard players add @s dr_rails 1
playsound minecraft:block.smithing_table.use block @a ~ ~1 ~ 0.6
function derailed:train/draw_loads
execute as @n[type=item_display,tag=dr_craft_from,distance=0..] run function derailed:train/draw_loads
