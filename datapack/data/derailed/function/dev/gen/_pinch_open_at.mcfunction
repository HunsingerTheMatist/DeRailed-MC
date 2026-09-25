
# Cuts the rock beside this cell's box, on the side the run is being opened
#  along: beside the cell and beside the one ahead of it, which the box stands
#  on together, the sides being the box's own where the track runs through
#  here
# Run as the cell's marker, positioned on it, with '#pinch_side' 1 for the
#  left and 2 for the right

execute if score #pinch_side dr_var matches 1 if score @s dr_dir matches 1 positioned ~ ~ ~-1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 1 if score @s dr_dir matches 1 positioned ~1 ~ ~-1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 1 if score @s dr_dir matches 2 positioned ~ ~ ~1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 1 if score @s dr_dir matches 2 positioned ~-1 ~ ~1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 1 if score @s dr_dir matches 3 positioned ~1 ~ ~ if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 1 if score @s dr_dir matches 3 positioned ~1 ~ ~1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 1 if score @s dr_dir matches 4 positioned ~-1 ~ ~ if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 1 if score @s dr_dir matches 4 positioned ~-1 ~ ~-1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut

execute if score #pinch_side dr_var matches 2 if score @s dr_dir matches 1 positioned ~ ~ ~1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 2 if score @s dr_dir matches 1 positioned ~1 ~ ~1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 2 if score @s dr_dir matches 2 positioned ~ ~ ~-1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 2 if score @s dr_dir matches 2 positioned ~-1 ~ ~-1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 2 if score @s dr_dir matches 3 positioned ~-1 ~ ~ if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 2 if score @s dr_dir matches 3 positioned ~-1 ~ ~1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 2 if score @s dr_dir matches 4 positioned ~1 ~ ~ if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score #pinch_side dr_var matches 2 if score @s dr_dir matches 4 positioned ~1 ~ ~-1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
