
# Looks at every tile of this row, then moves on to the row below
# Positioned on the row's western tile

scoreboard players set #stray_x dr_var 0
function derailed:dev/gen/_stray_col

scoreboard players add #stray_z dr_var 1
execute if score #stray_z dr_var matches ..15 positioned ~ ~ ~1 run function derailed:dev/gen/_stray_row
