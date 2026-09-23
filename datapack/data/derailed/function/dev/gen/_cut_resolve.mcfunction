
# Fills the cut in from both ends at once - first tile, then last, then second
#  and last but one - so that the passage takes the terrain of whatever it
#  opens onto at each end and the two meet in the middle
# Positioned at the section's corner

scoreboard players set #cut_lo dr_var 1
scoreboard players operation #cut_hi dr_var = #cut_n dr_var
function derailed:dev/gen/_cut_pair

# On hard a cut that came out water from end to end is a river instead: a
#  channel through the rock rather than a pool in it
execute if score #gen_difficulty dr_var matches 2 run function derailed:dev/gen/_cut_river

scoreboard players operation #gen_carved dr_var += #cut_n dr_var
kill @e[type=marker,tag=dr_cut,distance=0..]
