
# Gives every part of the piece just put on the track the piece's id
# Run in the game's dimension

scoreboard players operation @e[tag=dr_train_new,distance=0..] dr_tid = #train_ids dr_var
tag @e[tag=dr_train_new,distance=0..] remove dr_train_new
