
# Turns every region's own block into the block for the kind it rolled
# The river was cut in its own block, so none of these fills matches it
# Positioned at the section's corner

# Regions carried over the seam are not among these: their kinds never change, so
#  they grew straight into the block they are drawn in and have nothing to roll
execute as @e[type=marker,tag=dr_seed,distance=0..] run function derailed:dev/gen/_paint_seed
