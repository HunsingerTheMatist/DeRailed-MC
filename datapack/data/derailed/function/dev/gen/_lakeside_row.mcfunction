
# Looks at every tile of this row, then moves on to the row below
# Positioned on the row's western tile

scoreboard players set #lake_x dr_var 0
function derailed:dev/gen/_lakeside_col

scoreboard players add #lake_z dr_var 1
execute if score #lake_z dr_var matches ..15 positioned ~ ~ ~1 run function derailed:dev/gen/_lakeside_row
