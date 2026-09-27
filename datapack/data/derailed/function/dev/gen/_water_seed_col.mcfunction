
# Sets out from every tile of water in this column, then moves east as far as
#  this section's last column
# Positioned on the column's northern tile

scoreboard players set #wr_z dr_var 0
function derailed:dev/gen/_water_seed_row
scoreboard players add #wr_x dr_var 1
execute if score #wr_x dr_var matches ..31 positioned ~1 ~ ~ run function derailed:dev/gen/_water_seed_col
