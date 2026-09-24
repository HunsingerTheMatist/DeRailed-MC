
# Cuts one tile of rock beside the route to open a pinch up, counts it, and
#  puts yellow glass over it so the opening can be picked out from above
# Positioned on the tile

# Rock beside the first route is never opened for the second, since that rock
#  is what pinches the first
execute if score #cost_mode dr_var matches 1 if block ~ ~3 ~ #derailed:second_band run return 0

function derailed:dev/gen/_carve
setblock ~ ~1 ~ yellow_stained_glass strict
scoreboard players add #gen_opened dr_var 1
