# Draws what this wagon holds as piles on its bed, a layer for each, three at
#  most: the supply wagon its wood and iron and the crafting wagon its rails
# Run as the wagon's item display

scoreboard players operation #tid dr_temp = @s dr_tid
tag @e[type=item_display,tag=dr_load_here,distance=0..] remove dr_load_here
execute as @e[type=item_display,tag=dr_train_load,distance=0..] if score @s dr_tid = #tid dr_temp run tag @s add dr_load_here

scoreboard players set #load dr_temp 0
scoreboard players operation #load dr_temp = @s dr_wood
scoreboard players operation #load dr_temp < $BatchHeight dr_const
execute if score #load dr_temp matches ..0 run item replace entity @e[type=item_display,tag=dr_load_wood,tag=dr_load_here,distance=0..] contents with air
execute if score #load dr_temp matches 1.. run item replace entity @e[type=item_display,tag=dr_load_wood,tag=dr_load_here,distance=0..] contents with oak_log[item_model="derailed:wood"]
execute if score #load dr_temp matches 1.. as @e[type=item_display,tag=dr_load_wood,tag=dr_load_here,distance=0..] store result entity @s item.count int 1 run scoreboard players get #load dr_temp

scoreboard players set #load dr_temp 0
scoreboard players operation #load dr_temp = @s dr_iron
scoreboard players operation #load dr_temp < $BatchHeight dr_const
execute if score #load dr_temp matches ..0 run item replace entity @e[type=item_display,tag=dr_load_iron,tag=dr_load_here,distance=0..] contents with air
execute if score #load dr_temp matches 1.. run item replace entity @e[type=item_display,tag=dr_load_iron,tag=dr_load_here,distance=0..] contents with iron_block[item_model="derailed:iron"]
execute if score #load dr_temp matches 1.. as @e[type=item_display,tag=dr_load_iron,tag=dr_load_here,distance=0..] store result entity @s item.count int 1 run scoreboard players get #load dr_temp

scoreboard players set #load dr_temp 0
scoreboard players operation #load dr_temp = @s dr_rails
scoreboard players operation #load dr_temp < $BatchHeight dr_const
execute if score #load dr_temp matches ..0 run item replace entity @e[type=item_display,tag=dr_load_rail,tag=dr_load_here,distance=0..] contents with air
execute if score #load dr_temp matches 1.. run item replace entity @e[type=item_display,tag=dr_load_rail,tag=dr_load_here,distance=0..] contents with rail[item_model="derailed:rail"]
execute if score #load dr_temp matches 1.. as @e[type=item_display,tag=dr_load_rail,tag=dr_load_here,distance=0..] store result entity @s item.count int 1 run scoreboard players get #load dr_temp
