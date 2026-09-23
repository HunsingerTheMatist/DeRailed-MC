
# Cuts one tile of rock beside the route to open a pinch up, counts it, and
#  puts yellow glass over it so the opening can be picked out from above
# Positioned on the tile

function derailed:dev/gen/_carve
setblock ~ ~1 ~ yellow_stained_glass strict
scoreboard players add #gen_opened dr_var 1
