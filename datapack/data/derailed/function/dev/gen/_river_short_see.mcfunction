
# Weighs one of the corners next to the walk against the best it has found
# Run as the tile standing at that corner

execute if score @s dr_step > #riv_far dr_var run function derailed:dev/gen/_river_short_take
