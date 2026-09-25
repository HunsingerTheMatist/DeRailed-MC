
# Cuts one tile of rock beside the route to open a pinch up, counts it, and
#  puts yellow glass over it so the opening can be picked out from above
# Positioned on the tile

# Nothing outside the section is ever cut, the section before least of all:
#  the ring the flood lays round the section is what says a tile is outside
execute if block ~ ~2 ~ gray_stained_glass run return 0

# Nor is the station
execute if block ~ ~-15 ~ #derailed:prefab run return 0

# Rock beside the first route is never opened for the second, since that rock
#  is what pinches the first
execute if score #cost_mode dr_var matches 1 if block ~ ~3 ~ #derailed:second_band run return 0

function derailed:dev/gen/_carve
setblock ~ ~1 ~ yellow_stained_glass strict
scoreboard players add #gen_opened dr_var 1
