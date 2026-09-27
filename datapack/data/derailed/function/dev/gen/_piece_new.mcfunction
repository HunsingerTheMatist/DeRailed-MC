
# Makes this marker a piece's, tagged $(tag), holding '#pc_n' creatures
# Run as the new marker

tag @s add dr_piece
$tag @s add $(tag)
scoreboard players operation @s dr_size = #pc_n dr_var
