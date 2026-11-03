
# Puts a supply wagon of team '#train_team' on the track, empty, with its
#  middle '#train_s' along the team's path, in thousandths of a block: its
#  model with its interaction riding it, and its shulker riding it on an
#  interaction 0.3 tall, its axles 0.6 either way, where its wheels are, a
#  display for each pair of wheels, and a display each for the wood and the
#  iron it holds, drawn at 0.8 of a pile's size
# Its parts stand wherever this runs until the trains next move
# Run in the game's dimension

scoreboard players add #train_ids dr_var 1
summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_train_piece","dr_train_supply","dr_train_box","dr_train_new"],teleport_duration:1,interpolation_duration:1,item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:supply_wagon"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]},Passengers:[{id:"minecraft:interaction",Tags:["dr_train_part","dr_train_new"],width:0f,height:0.3f,Passengers:[{id:"minecraft:shulker",Tags:["dr_train_part","dr_train_new","dr_hard"],Invulnerable:true,NoAI:true,Silent:true,Health:1,attributes:[{id:"minecraft:scale",base:2.5}],active_effects:[{id:"minecraft:invisibility",duration:-1,show_particles:false}]}]},{id:"minecraft:interaction",Tags:["dr_train_part","dr_train_click","dr_train_new"],width:2.51f,height:2.81f}]}
summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_train_wheel","dr_wheel_big","dr_wheel_1","dr_train_new"],teleport_duration:1,interpolation_duration:1,item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:train_big_wheels"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]}}
summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_train_wheel","dr_wheel_big","dr_wheel_2","dr_train_new"],teleport_duration:1,interpolation_duration:1,item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:train_big_wheels"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]}}
summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_train_load","dr_supply_load","dr_load_wood","dr_train_new"],teleport_duration:1,interpolation_duration:1,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_train_load","dr_supply_load","dr_load_iron","dr_train_new"],teleport_duration:1,interpolation_duration:1,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0.4f,0f],scale:[1.6f,1.6f,1.6f]}}

scoreboard players set #train_front dr_temp 1
scoreboard players operation #train_axle dr_temp = #train_s dr_temp
scoreboard players add #train_axle dr_temp 600
execute summon marker run function derailed:train/_axle_new
scoreboard players set #train_front dr_temp 0
scoreboard players operation #train_axle dr_temp = #train_s dr_temp
scoreboard players remove #train_axle dr_temp 600
execute summon marker run function derailed:train/_axle_new

# Each of its piles holds the item it draws
scoreboard players operation @e[type=item_display,tag=dr_load_wood,tag=dr_train_new,distance=0..] dr_item = $Wood dr_const
scoreboard players operation @e[type=item_display,tag=dr_load_iron,tag=dr_train_new,distance=0..] dr_item = $Iron dr_const
scoreboard players set @e[type=item_display,tag=dr_train_supply,tag=dr_train_new,distance=0..] dr_wood 0
scoreboard players set @e[type=item_display,tag=dr_train_supply,tag=dr_train_new,distance=0..] dr_iron 0

function derailed:train/_spawned
execute as @e[type=item_display,tag=dr_train_supply,distance=0..] if score @s dr_tid = #train_ids dr_var run function derailed:train/draw_loads
