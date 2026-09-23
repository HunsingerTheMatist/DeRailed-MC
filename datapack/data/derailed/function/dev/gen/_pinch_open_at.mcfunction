
# Cuts the rock on the left of this cell of the run, the left being the box's
#  own where the track runs through here
# Run as the cell's marker, positioned on it

execute if score @s dr_dir matches 1 positioned ~ ~ ~-1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score @s dr_dir matches 2 positioned ~ ~ ~1 if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score @s dr_dir matches 3 positioned ~1 ~ ~ if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
execute if score @s dr_dir matches 4 positioned ~-1 ~ ~ if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_pinch_cut
