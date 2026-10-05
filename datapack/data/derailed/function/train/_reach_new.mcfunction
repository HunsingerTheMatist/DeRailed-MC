
# Makes this marker the front or back end of a train, '#train_front' 1 or 0,
#  '#train_axle' along the path: an axle that moves with the train but belongs
#  to no piece
# Run as the new marker

function derailed:train/_axle_new
tag @s remove dr_train_new
tag @s remove dr_axle_front
tag @s remove dr_axle_back
tag @s add dr_reach
execute if score #train_front dr_temp matches 1 run tag @s add dr_reach_front
execute if score #train_front dr_temp matches 0 run tag @s add dr_reach_back
scoreboard players set @s dr_tid 0
