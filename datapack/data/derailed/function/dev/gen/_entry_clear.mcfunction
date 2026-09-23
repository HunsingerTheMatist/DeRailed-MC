
# Keeps the first section's way in off rock, the same as every section's way
#  out, since nothing before it chose the row
# Positioned at the section's corner

scoreboard players set #edge_col dr_var 0
scoreboard players operation #edge_ref dr_var = #gen_exit dr_var
scoreboard players operation #edge_row dr_var = #gen_entry dr_var
function derailed:dev/gen/_edge_clear
scoreboard players operation #gen_entry dr_var = #edge_row dr_var
execute store result storage derailed:gen r.entry int 1 run scoreboard players get #gen_entry dr_var
