
# Closes the run the last window ended, if one was open
# A run of n windows costs n cubed, so one long pinch weighs far more than the
#  same length in pieces, and the longest run is kept for whoever has to open
#  the section up

execute if score #pinch_run dr_var matches 0 run return 0

scoreboard players operation #pinch_cube dr_var = #pinch_run dr_var
scoreboard players operation #pinch_cube dr_var *= #pinch_run dr_var
scoreboard players operation #pinch_cube dr_var *= #pinch_run dr_var
scoreboard players operation #gen_pinch dr_var += #pinch_cube dr_var

execute if score #pinch_run dr_var > #pinch_top dr_var run scoreboard players operation #pinch_top_id dr_var = #pinch_runs dr_var
execute if score #pinch_run dr_var > #pinch_top dr_var run scoreboard players operation #pinch_top dr_var = #pinch_run dr_var

scoreboard players set #pinch_run dr_var 0
