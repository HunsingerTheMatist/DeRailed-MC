
# Makes this marker an axle of the piece being put on the track, its front one
#  where '#train_front' is 1 and its back one otherwise, '#train_axle' along
#  the path at the height the path runs at, and stands it there
# Run as the new marker

tag @s add dr_train_part
tag @s add dr_axle
tag @s add dr_train_new
execute if score #train_front dr_temp matches 1 run tag @s add dr_axle_front
execute if score #train_front dr_temp matches 0 run tag @s add dr_axle_back
execute store result entity @s Pos[1] double 0.001 run data get storage derailed:train y
scoreboard players set @s dr_ai 0
function derailed:train/_axle_load
function derailed:train/_axle_seek
function derailed:train/_axle_pos
