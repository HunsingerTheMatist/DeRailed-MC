
# Gives every part of the piece just put on the track the piece's id and the
#  team of its train, '#train_team'
# Run in the game's dimension

scoreboard players operation @e[tag=dr_train_new,distance=0..] dr_tid = #train_ids dr_var
scoreboard players operation @e[tag=dr_train_new,distance=0..] dr_team = #train_team dr_temp
tag @e[tag=dr_train_new,distance=0..] remove dr_train_new
