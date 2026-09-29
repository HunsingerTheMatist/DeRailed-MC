
# Lays out everything the attempts draw their kinds over: the pieces, the
#  seeds and the regions they grow, hard's wall, the rivers and the stray sweep
# Positioned at the section's corner, with the station laid

# The pieces are laid before any seed, since nothing grows over them
function derailed:dev/gen/_pieces

function derailed:dev/gen/scatter
function derailed:dev/gen/grow

# The regions as they grew are kept on a spare layer, for a section that has to
#  be built again from them
clone ~ ~ ~ ~31 ~ ~15 ~ ~12 ~ strict

# Hard gets a band of rock across it for the route to have to cut through,
#  picked from the regions once they have grown so that it has no gap
function derailed:dev/gen/_lay_snap
execute if score #gen_difficulty dr_var matches 2 run function derailed:dev/gen/wall

# The kinds layer starts out as the regions exactly as they grew, which is both
#  what the river reads and what painting swaps out from under itself
# The sections before have theirs drawn in kinds by now, so a river running along
#  the seam compares like with like across it
clone ~ ~ ~ ~31 ~ ~15 ~ ~5 ~ strict

# A section whose rivers found nowhere to start goes on without them, counted
#  by the search, since nothing a reroll does can put a river into it
execute if score #gen_rivers dr_var matches 1 run function derailed:dev/gen/rivers

# Held for a look at the river, nothing is drawn over it
execute if score #gen_riv_hold dr_var matches 1 run return 0

# A tile left with no edge to another of its own region, which is what a river
#  can leave behind, is handed to a region beside it before the kinds are drawn
function derailed:dev/gen/strays
