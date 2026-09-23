
# Sets up a marker just put on a rock tile the route is to cut through: which
#  run it is in and where along the run it lies
# Run as the marker

tag @s add dr_cut
scoreboard players operation @s dr_step = #cut_runs dr_var
scoreboard players operation @s dr_wave = #cut_pos dr_var
