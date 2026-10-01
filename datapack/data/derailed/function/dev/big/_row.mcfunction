
# Looks at every tile of this row, then moves on to the row below
# Positioned on the row's western tile

scoreboard players set #big_x dr_temp 0
function derailed:dev/big/_col

scoreboard players add #big_z dr_temp 1
execute if score #big_z dr_temp matches ..15 positioned ~ ~ ~1 run function derailed:dev/big/_row
