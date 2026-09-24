
# Repaints every tile of this row that belongs to the region in 'p', then
#  moves on to the row below
# Positioned on the row's western tile

scoreboard players set #each_x dr_var 0
function derailed:dev/gen/_repaint_col

scoreboard players add #each_z dr_var 1
execute if score #each_z dr_var matches ..15 positioned ~ ~ ~1 run function derailed:dev/gen/_repaint_row
