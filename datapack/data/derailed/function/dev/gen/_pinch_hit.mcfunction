
# Counts a pinched window into the run it is part of, opening a run if none is,
#  and marks all three cells of the window for whoever has to open the run up:
#  the cell the trace came from, this one, and the one it came from before that
# The cell nearest the exit is marked first, so that the run's numbering starts
#  at its exit end
# Positioned on the cell, with '#gen_back' the way its parent lies and
#  '#pinch_pback' the way the cell before it lay from its own parent

execute if score #pinch_run dr_var matches 0 run scoreboard players add #pinch_runs dr_var 1
scoreboard players add #pinch_run dr_var 1

# The cell the trace came from lies the other way from where that cell's parent
#  lay, which is this cell
scoreboard players operation #pinch_dir dr_var = #pinch_pback dr_var
execute if score #pinch_pback dr_var matches 1 positioned ~1 ~ ~ run function derailed:dev/gen/_pinch_mark
execute if score #pinch_pback dr_var matches 2 positioned ~-1 ~ ~ run function derailed:dev/gen/_pinch_mark
execute if score #pinch_pback dr_var matches 3 positioned ~ ~ ~1 run function derailed:dev/gen/_pinch_mark
execute if score #pinch_pback dr_var matches 4 positioned ~ ~ ~-1 run function derailed:dev/gen/_pinch_mark

scoreboard players operation #pinch_dir dr_var = #gen_back dr_var
function derailed:dev/gen/_pinch_mark
execute if score #gen_back dr_var matches 1 positioned ~-1 ~ ~ run function derailed:dev/gen/_pinch_mark
execute if score #gen_back dr_var matches 2 positioned ~1 ~ ~ run function derailed:dev/gen/_pinch_mark
execute if score #gen_back dr_var matches 3 positioned ~ ~ ~-1 run function derailed:dev/gen/_pinch_mark
execute if score #gen_back dr_var matches 4 positioned ~ ~ ~1 run function derailed:dev/gen/_pinch_mark
