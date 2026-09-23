
# Moves the row in '#edge_row' off rock, on column '#edge_col' of the section,
#  when the tile there is rock and any other row of that column is not
# Positioned at the section's corner, with '#edge_ref' the row the new one is
#  to keep far from

execute store result storage derailed:gen e.col int 1 run scoreboard players get #edge_col dr_var
execute store result storage derailed:gen e.row int 1 run scoreboard players get #edge_row dr_var
function derailed:dev/gen/_edge_check with storage derailed:gen e
