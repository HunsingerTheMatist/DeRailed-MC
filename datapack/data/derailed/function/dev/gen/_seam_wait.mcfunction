
# Sets up a tile waiting on its carried region
# Run as the marker just summoned on it

tag @s add dr_seam_wait
scoreboard players operation @s dr_id = #gen_id dr_var
scoreboard players operation @s dr_wake = #seam_wake dr_var
