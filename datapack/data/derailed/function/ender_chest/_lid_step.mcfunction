# Opens this chest's lid a step further, its step in its item's custom model data,
#  and leaves it open once it is all the way
# Run as the chest's item display

scoreboard players add @s dr_lid 1
execute store result entity @s item.components."minecraft:custom_model_data".floats[0] float 1 run scoreboard players get @s dr_lid
execute if score @s dr_lid matches 10.. run tag @s remove dr_lid_opening
