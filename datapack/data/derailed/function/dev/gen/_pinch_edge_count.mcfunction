
# Counts this cell into the run being opened, and into the cells lying by
#  either end of the route
# Run as the cell's marker

scoreboard players add #pinch_top dr_var 1
execute if entity @s[tag=dr_pinch_near_in] run scoreboard players add #pinch_near_in dr_var 1
execute if entity @s[tag=dr_pinch_near_out] run scoreboard players add #pinch_near_out dr_var 1
