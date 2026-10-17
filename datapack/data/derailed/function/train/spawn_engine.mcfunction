
# Puts an engine on the track with its middle '#train_s' along the path, in
#  thousandths of a block: its model with an interaction riding it, its two
#  shulkers each riding an interaction 0.3 tall on an item display with
#  another interaction, its axles 1.2
#  either way, at its front and back driving wheels as its model is drawn, and
#  a display for each pair of wheels, three big and the small pair in front
# Its parts stand wherever this runs until the trains next move
# Run in the game's dimension

scoreboard players add #train_ids dr_var 1
summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_train_piece","dr_train_engine","dr_train_new"],teleport_duration:1,interpolation_duration:1,item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:train"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2.5f,2.5f,2.5f]},Passengers:[{id:"minecraft:interaction",Tags:["dr_train_part","dr_train_click","dr_train_new"],width:0.75f,height:2.81f}]}
summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_train_carrier","dr_train_carrier_a","dr_train_box","dr_train_new"],teleport_duration:1,Passengers:[{id:"minecraft:interaction",Tags:["dr_train_part","dr_train_new"],width:0f,height:0.3f,Passengers:[{id:"minecraft:shulker",Tags:["dr_train_part","dr_train_new","dr_hard"],Invulnerable:true,NoAI:true,Silent:true,Health:1,attributes:[{id:"minecraft:scale",base:2.5}],active_effects:[{id:"minecraft:invisibility",duration:-1,show_particles:false}]}]},{id:"minecraft:interaction",Tags:["dr_train_part","dr_train_click","dr_train_new"],width:2.51f,height:2.81f}]}
summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_train_carrier","dr_train_carrier_b","dr_train_box","dr_train_new"],teleport_duration:1,Passengers:[{id:"minecraft:interaction",Tags:["dr_train_part","dr_train_new"],width:0f,height:0.3f,Passengers:[{id:"minecraft:shulker",Tags:["dr_train_part","dr_train_new","dr_hard"],Invulnerable:true,NoAI:true,Silent:true,Health:1,attributes:[{id:"minecraft:scale",base:2.5}],active_effects:[{id:"minecraft:invisibility",duration:-1,show_particles:false}]}]},{id:"minecraft:interaction",Tags:["dr_train_part","dr_train_click","dr_train_new"],width:2.51f,height:2.81f}]}
summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_train_wheel","dr_wheel_big","dr_wheel_1","dr_train_new"],teleport_duration:1,interpolation_duration:1,item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:train_big_wheels"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]}}
summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_train_wheel","dr_wheel_big","dr_wheel_2","dr_train_new"],teleport_duration:1,interpolation_duration:1,item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:train_big_wheels"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]}}
summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_train_wheel","dr_wheel_big","dr_wheel_3","dr_train_new"],teleport_duration:1,interpolation_duration:1,item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:train_big_wheels"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]}}
summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_train_wheel","dr_wheel_small","dr_wheel_4","dr_train_new"],teleport_duration:1,interpolation_duration:1,item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:train_small_wheels"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]}}

scoreboard players set #train_front dr_temp 1
scoreboard players operation #train_axle dr_temp = #train_s dr_temp
scoreboard players add #train_axle dr_temp 1200
execute summon marker run function derailed:train/_axle_new
scoreboard players set #train_front dr_temp 0
scoreboard players operation #train_axle dr_temp = #train_s dr_temp
scoreboard players remove #train_axle dr_temp 1200
execute summon marker run function derailed:train/_axle_new

function derailed:train/_spawned
