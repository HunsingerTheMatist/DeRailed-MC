# Puts a light reaching '$PlayerLight' here for the player with the id
#  '#pid', if a slot is free
# Run in the game's dimension

execute store result score #light dr_temp run function derailed:light/_slot
execute if score #light dr_temp matches ..-1 run return fail
scoreboard players operation #light dr_temp += $PlayerLight dr_config
summon item_display ~ ~ ~ {Tags:["dr_light","dr_light_player","dr_light_kept","dr_light_new"],Glowing:1b,view_range:4f,teleport_duration:1,item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:light_marker"}}}
scoreboard players operation @e[type=item_display,tag=dr_light_new,distance=0..] dr_player_id = #pid dr_temp
function derailed:light/_new
