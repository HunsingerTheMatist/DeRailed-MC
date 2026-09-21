
# Chooses the row the track leaves by, favouring rows far from where it came in

# Three rolls, keeping the one furthest from the entry row
# The real weighting is the squared distance; best of three leans the same way
#  for a fraction of the work
execute store result score #gen_exit dr_var run random value 0..15
scoreboard players operation #gen_best dr_var = #gen_exit dr_var
scoreboard players operation #gen_best dr_var -= #gen_entry dr_var
execute if score #gen_best dr_var matches ..-1 run scoreboard players operation #gen_best dr_var *= $NegOne dr_const

function derailed:dev/gen/_try_exit
function derailed:dev/gen/_try_exit
