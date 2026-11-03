
# Makes this marker an axle of the piece being put on the track of team
#  '#train_team', its front one where '#train_front' is 1 and its back one
#  otherwise, '#train_axle' along the team's path at the height the path runs
#  at, and stands it there
# Run as the new marker

tag @s add dr_train_part
tag @s add dr_axle
tag @s add dr_train_new
execute if score #train_front dr_temp matches 1 run tag @s add dr_axle_front
execute if score #train_front dr_temp matches 0 run tag @s add dr_axle_back
scoreboard players operation @s dr_team = #train_team dr_temp
execute store result storage derailed:train arg.team int 1 run scoreboard players get @s dr_team
function derailed:train/_axle_y with storage derailed:train arg
scoreboard players set @s dr_ai 0
function derailed:train/_axle_load
function derailed:train/_axle_seek
function derailed:train/_axle_pos
