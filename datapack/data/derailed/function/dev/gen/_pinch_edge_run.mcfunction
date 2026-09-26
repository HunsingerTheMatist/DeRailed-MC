
# Tags 'dr_pinch_edge' every cell of the run this cell is part of
# Run as the cell's marker

scoreboard players operation #pe_run dr_var = @s dr_step
execute as @e[type=marker,tag=dr_pinch,distance=0..] if score @s dr_step = #pe_run dr_var run tag @s add dr_pinch_edge
