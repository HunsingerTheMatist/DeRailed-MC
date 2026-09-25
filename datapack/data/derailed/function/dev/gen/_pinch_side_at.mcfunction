
# Counts the rock either side of this cell's box, beside the cell and beside
#  the one ahead of it, which the box stands on together
# Run as the cell's marker, positioned on it

execute store result score #pinch_col dr_var run data get entity @s Pos[0]
scoreboard players operation #pinch_col dr_var -= #gen_cx dr_var
execute store result score #pinch_row dr_var run data get entity @s Pos[2]
scoreboard players operation #pinch_row dr_var -= #gen_cz dr_var
function derailed:dev/gen/_pinch_side

execute if score @s dr_dir matches 1 run scoreboard players add #pinch_col dr_var 1
execute if score @s dr_dir matches 2 run scoreboard players remove #pinch_col dr_var 1
execute if score @s dr_dir matches 3 run scoreboard players add #pinch_row dr_var 1
execute if score @s dr_dir matches 4 run scoreboard players remove #pinch_row dr_var 1
execute if score @s dr_dir matches 1 positioned ~1 ~ ~ run function derailed:dev/gen/_pinch_side
execute if score @s dr_dir matches 2 positioned ~-1 ~ ~ run function derailed:dev/gen/_pinch_side
execute if score @s dr_dir matches 3 positioned ~ ~ ~1 run function derailed:dev/gen/_pinch_side
execute if score @s dr_dir matches 4 positioned ~ ~ ~-1 run function derailed:dev/gen/_pinch_side
