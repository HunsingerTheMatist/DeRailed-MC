
# Sets up the note just left at a choice
# Run as the marker

tag @s add dr_riv_node
scoreboard players operation @s dr_depth = #riv_depth dr_var

# The way the head arrived, which is what 'straight on' means when it comes back
scoreboard players operation @s dr_dir = #riv_dir dr_var

# And which side of the line it was hugging, since a branch given up on leaves
#  that on whatever side it ended with: without putting it back, the first step
#  taken after coming here lays its water on the wrong flank and the river breaks
