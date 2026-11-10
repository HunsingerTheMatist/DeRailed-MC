
# Brings the void the map starts at in over the first section's western seam,
#  growing from three starts the scatter picked ('_void_pick'), each on a row
#  of the first column or up to 2 tiles west of it, reaching each tile of the
#  column on the wave it would from the nearest, and growing on from there
#  wherever no seed is nearer
# The void is region 31, obsidian on the layer the regions grow on, which
#  nothing grows into, cuts, paints or crosses; a tile already taken, the
#  station's among them, is passed over
# Positioned at the section's corner

scoreboard players set #void_r dr_var 0
function derailed:dev/gen/_void_row
