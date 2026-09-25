
# Counts a pinched box into the run it is part of, opening a run if none is,
#  and marks the cell the box stands on, the one behind this cell, for whoever
#  has to open the run up
# The cell nearest the exit is marked first, so that the run's numbering
#  starts at its exit end
# Positioned on the cell, with '#gen_back' the way its parent lies

execute if score #pinch_run dr_var matches 0 run scoreboard players add #pinch_runs dr_var 1
scoreboard players add #pinch_run dr_var 1

scoreboard players operation #pinch_dir dr_var = #gen_back dr_var
execute if score #gen_back dr_var matches 1 positioned ~-1 ~ ~ run function derailed:dev/gen/_pinch_mark
execute if score #gen_back dr_var matches 2 positioned ~1 ~ ~ run function derailed:dev/gen/_pinch_mark
execute if score #gen_back dr_var matches 3 positioned ~ ~ ~-1 run function derailed:dev/gen/_pinch_mark
execute if score #gen_back dr_var matches 4 positioned ~ ~ ~1 run function derailed:dev/gen/_pinch_mark
