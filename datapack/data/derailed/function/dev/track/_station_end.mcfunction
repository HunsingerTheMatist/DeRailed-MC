# Makes this new marker the end of the track of team '#train_team', tagged
#  'dr_end_on', come into and leaving east and facing east
# Run as the new marker

tag @s add dr_track_end
tag @s add dr_end_on
scoreboard players operation @s dr_team = #train_team dr_temp
scoreboard players set @s dr_adin 1
scoreboard players set @s dr_adout 1
data modify entity @s Rotation set value [270f, 0f]
