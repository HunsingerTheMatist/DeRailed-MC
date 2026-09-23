
# Counts '#pinch_keep' down until a run that long would pass the ceiling

scoreboard players operation #pinch_cube dr_var = #pinch_keep dr_var
scoreboard players operation #pinch_cube dr_var *= #pinch_keep dr_var
scoreboard players operation #pinch_cube dr_var *= #pinch_keep dr_var
execute if score #pinch_cube dr_var <= #gen_pinch_max dr_var run return 0

scoreboard players remove #pinch_keep dr_var 1
execute if score #pinch_keep dr_var matches 0.. run function derailed:dev/gen/_pinch_fit
