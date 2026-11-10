
# Counts the wood tiles and the iron tiles within reach of a route in each of
#  the section's columns, into the list 'cols' from west to east, one entry of
#  'w' and 'i' a column, and the two over the last fifteen columns into
#  '#tail_w' and '#tail_i'
# A tile is within reach where the supply check's flood left its mark two
#  above it; the first section's start station's wood and iron count toward
#  the columns they are piled on, 2 and 3
# Positioned at the section's corner, on the visible layer, while the supply
#  check's flood is still laid

data modify storage derailed:gen cols set value []
scoreboard players set #col_x dr_var 0
scoreboard players set #tail_w dr_var 0
scoreboard players set #tail_i dr_var 0
function derailed:dev/gen/_col_scan_at
execute if score #gen_section dr_var matches 0 if score #gen_station dr_var matches 1 run function derailed:dev/gen/_start_cols
