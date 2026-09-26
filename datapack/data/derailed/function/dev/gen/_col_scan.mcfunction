
# Counts the wood tiles and the iron tiles within reach of a route in each of
#  the section's columns, into the list 'cols' from west to east, one entry of
#  'w' and 'i' a column, and the two over the last fifteen columns into
#  '#tail_w' and '#tail_i'
# A tile is within reach where the supply check's flood left its mark two
#  above it
# Positioned at the section's corner, on the visible layer, while the supply
#  check's flood is still laid

data modify storage derailed:gen cols set value []
scoreboard players set #col_x dr_var 0
scoreboard players set #tail_w dr_var 0
scoreboard players set #tail_i dr_var 0
function derailed:dev/gen/_col_scan_at
