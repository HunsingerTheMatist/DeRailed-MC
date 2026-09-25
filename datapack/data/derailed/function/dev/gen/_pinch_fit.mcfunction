
# Counts '#pinch_keep' down until a run that long fits the room the ceiling
#  leaves it, and no further than '#pinch_keep_min'

scoreboard players operation #pinch_cube dr_var = #pinch_keep dr_var
scoreboard players operation #pinch_cube dr_var *= #pinch_keep dr_var
scoreboard players operation #pinch_cube dr_var *= #pinch_keep dr_var
execute if score #pinch_cube dr_var <= #pinch_room dr_var run return 0
execute if score #pinch_keep dr_var <= #pinch_keep_min dr_var run return 0

scoreboard players remove #pinch_keep dr_var 1
function derailed:dev/gen/_pinch_fit
