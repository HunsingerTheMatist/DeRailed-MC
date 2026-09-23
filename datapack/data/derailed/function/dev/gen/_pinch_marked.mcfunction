
# Sets up a marker just put on a cell of a pinched run: which run, the way the
#  box points there, and where along the run it lies, counted from the exit end
# Run as the marker

tag @s add dr_pinch
scoreboard players operation @s dr_step = #pinch_runs dr_var
scoreboard players operation @s dr_dir = #pinch_dir dr_var
scoreboard players add #pinch_seq dr_var 1
scoreboard players operation @s dr_wave = #pinch_seq dr_var
