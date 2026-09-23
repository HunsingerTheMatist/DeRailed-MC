
# Weighs row $(row) of column $(col) against the best row kept so far

$execute if block ~$(col) ~ ~$(row) gray_concrete run return fail

$scoreboard players set #edge_far dr_var $(row)
scoreboard players operation #edge_far dr_var -= #edge_ref dr_var
execute if score #edge_far dr_var matches ..-1 run scoreboard players operation #edge_far dr_var *= $NegOne dr_const

# The row before the distance, since updating the distance first would stop the
#  row from matching
$execute if score #edge_far dr_var > #edge_best dr_var run scoreboard players set #edge_row dr_var $(row)
execute if score #edge_far dr_var > #edge_best dr_var run scoreboard players operation #edge_best dr_var = #edge_far dr_var
