
# Scatters one section worth of seeds from the section's corner
# 18 seeds over 32x16 is the grass density, the sparsest of the biomes

# The section before keeps its seeds through the scatter, so the spacing carries
#  over the boundary: without them a seed can land a tile inside this section
#  while one of theirs sits a tile the other side, which is closer than two seeds
#  are allowed anywhere else on the map, and the region it grows takes the whole
#  edge off whatever was being carried over
kill @e[type=marker,tag=dr_prev_seed,distance=0..]
execute as @e[type=marker,tag=dr_seed,distance=0..] run function derailed:dev/gen/_age_seed

scoreboard players operation #gen_left dr_var = $SectionSeeds dr_const
function derailed:dev/gen/_seed

# Each region grows as its own block so that the boundary between two of them can
#  be seen even where both end up the same kind, which is what a river follows
scoreboard players set #gen_next dr_var 0
execute as @e[type=marker,tag=dr_seed,distance=0..] run function derailed:dev/gen/_number_seed

execute as @e[type=marker,tag=dr_seed,distance=0..] at @s run function derailed:dev/gen/_seed_mark
