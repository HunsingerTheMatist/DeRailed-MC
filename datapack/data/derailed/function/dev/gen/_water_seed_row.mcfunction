
# Sets out from this tile if it is water, marking it one layer down, then moves
#  south to the column's end

execute if block ~ ~ ~ #derailed:cost_water run setblock ~ ~-1 ~ blue_stained_glass strict
execute if block ~ ~ ~ #derailed:cost_water summon marker run function derailed:dev/gen/_water_new
scoreboard players add #wr_z dr_var 1
execute if score #wr_z dr_var matches ..15 positioned ~ ~ ~1 run function derailed:dev/gen/_water_seed_row
