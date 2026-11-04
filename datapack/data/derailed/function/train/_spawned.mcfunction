
# Gives every part of the piece just put on the track the piece's id and the
#  team of its train, '#train_team'
# Run in the game's dimension

scoreboard players operation @e[tag=dr_train_new,distance=0..] dr_tid = #train_ids dr_var
scoreboard players operation @e[tag=dr_train_new,distance=0..] dr_team = #train_team dr_temp

# Every other piece of the train, counting back from its front, stands 0.002
#  higher, so two pieces turning into each other on a curve never draw their
#  faces at the same height
scoreboard players set #n dr_temp 0
execute as @e[type=item_display,tag=dr_train_piece,tag=!dr_train_new,distance=0..] if score @s dr_team = #train_team dr_temp run scoreboard players add #n dr_temp 1
scoreboard players operation #n dr_temp %= $Two dr_const
execute if score #n dr_temp matches 1 run tag @e[type=item_display,tag=dr_train_piece,tag=dr_train_new,distance=0..] add dr_train_raised

tag @e[tag=dr_train_new,distance=0..] remove dr_train_new
