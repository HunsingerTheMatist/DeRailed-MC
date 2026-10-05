
# Puts the markers at either end of a train, which keep barriers in the two
#  blocks over the rails of every block the train covers all of, so nothing
#  gets between its pieces: the front one '#train_front_s' along the path and
#  the back one '#train_back_s', in thousandths of a block, each with a trail
#  on the block it is on, then lays the barriers between them
# Run in the game's dimension

scoreboard players set #train_front dr_temp 1
scoreboard players operation #train_axle dr_temp = #train_front_s dr_temp
execute summon marker run function derailed:train/_reach_new
scoreboard players set #train_front dr_temp 0
scoreboard players operation #train_axle dr_temp = #train_back_s dr_temp
execute summon marker run function derailed:train/_reach_new
execute as @n[type=marker,tag=dr_reach_front,distance=0..] at @s align xz positioned ~0.5 ~ ~0.5 summon marker run tag @s add dr_trail_front
execute as @n[type=marker,tag=dr_reach_back,distance=0..] at @s align xz positioned ~0.5 ~ ~0.5 summon marker run tag @s add dr_trail_back
tag @e[type=marker,tag=dr_trail_front,distance=0..] add dr_train_part
tag @e[type=marker,tag=dr_trail_back,distance=0..] add dr_train_part

scoreboard players set #train_front dr_temp 0
scoreboard players operation #train_axle dr_temp = #train_back_s dr_temp
scoreboard players operation #left dr_temp = #train_front_s dr_temp
scoreboard players operation #left dr_temp -= #train_back_s dr_temp
execute summon marker run function derailed:train/_reach_lay
