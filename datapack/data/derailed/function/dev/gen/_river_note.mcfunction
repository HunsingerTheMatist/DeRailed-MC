
# Sets up the note just left at a choice
# Run as the marker

tag @s add dr_riv_node
scoreboard players operation @s dr_depth = #riv_depth dr_var

# The way the head arrived, which is what 'straight on' means when it comes back
scoreboard players operation @s dr_dir = #riv_dir dr_var
