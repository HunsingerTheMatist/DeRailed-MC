# Cools every piece of this piece's train, which the rain has hit
# Run as the piece's item display

scoreboard players operation #team dr_temp = @s dr_team
execute as @e[type=item_display,tag=dr_train_piece,distance=0..] if score @s dr_team = #team dr_temp run function derailed:weather/_cool
