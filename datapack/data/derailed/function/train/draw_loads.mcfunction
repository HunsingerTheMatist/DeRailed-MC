# Draws the supply wagon's wood and iron and the crafting wagon's rails as
#  piles on their beds, a layer for each, three at most

scoreboard players operation #load dr_temp = $SupplyWood dr_var
scoreboard players operation #load dr_temp < $BatchHeight dr_const
execute if score #load dr_temp matches ..0 run item replace entity @e[type=item_display,tag=dr_load_wood] contents with air
execute if score #load dr_temp matches 1.. run item replace entity @e[type=item_display,tag=dr_load_wood] contents with oak_log[item_model="derailed:wood"]
execute if score #load dr_temp matches 1.. as @e[type=item_display,tag=dr_load_wood] store result entity @s item.count int 1 run scoreboard players get #load dr_temp

scoreboard players operation #load dr_temp = $SupplyIron dr_var
scoreboard players operation #load dr_temp < $BatchHeight dr_const
execute if score #load dr_temp matches ..0 run item replace entity @e[type=item_display,tag=dr_load_iron] contents with air
execute if score #load dr_temp matches 1.. run item replace entity @e[type=item_display,tag=dr_load_iron] contents with iron_block[item_model="derailed:iron"]
execute if score #load dr_temp matches 1.. as @e[type=item_display,tag=dr_load_iron] store result entity @s item.count int 1 run scoreboard players get #load dr_temp

scoreboard players operation #load dr_temp = $Rails dr_var
scoreboard players operation #load dr_temp < $BatchHeight dr_const
execute if score #load dr_temp matches ..0 run item replace entity @e[type=item_display,tag=dr_load_rail] contents with air
execute if score #load dr_temp matches 1.. run item replace entity @e[type=item_display,tag=dr_load_rail] contents with rail[item_model="derailed:rail"]
execute if score #load dr_temp matches 1.. as @e[type=item_display,tag=dr_load_rail] store result entity @s item.count int 1 run scoreboard players get #load dr_temp
