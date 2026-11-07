# Puts a light reaching '$TrainLight' on this piece of a train, 1.5 blocks
#  over its track, if a slot is free
# Run as the piece's item display, at it, in the game's dimension

execute store result score #light dr_temp run function derailed:light/_slot
execute if score #light dr_temp matches ..-1 run return fail
scoreboard players operation #light dr_temp += $TrainLight dr_config
summon item_display ~ ~ ~ {Tags:["dr_light","dr_light_piece","dr_light_new"],Glowing:1b,view_range:4f,item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:light_marker"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,1.5f,0f],scale:[1f,1f,1f]}}
ride @n[type=item_display,tag=dr_light_new,distance=0..] mount @s
function derailed:light/_new
