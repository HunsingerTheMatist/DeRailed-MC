
# Lays hard's wall over the regions as they grew, and starts the kinds layer
#  from them
# Positioned at the section's corner

# Hard gets a band of rock across it for the route to have to cut through,
#  picked from the regions once they have grown so that it has no gap
function derailed:dev/gen/_lay_snap
execute if score #gen_difficulty dr_var matches 2 run function derailed:dev/gen/wall

# The kinds layer starts out as the regions exactly as they grew, which is both
#  what the river reads and what painting swaps out from under itself
# The sections before have theirs drawn in kinds by now, so a river running along
#  the seam compares like with like across it
clone ~ ~ ~ ~31 ~ ~15 ~ ~5 ~ strict

scoreboard players set #q_step dr_var 4
return 1
