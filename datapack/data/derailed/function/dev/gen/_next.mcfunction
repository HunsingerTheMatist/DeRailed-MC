
# Joins the nearest seed in the search window that is not already on the chain
# Takes $(x), the near face of the window, and $(z), its near edge

# The window only reaches forward, so the chain can never double back on itself
# Reaching 12 ahead rather than the whole section stops the chain jumping over a
#  seed, since anything jumped over is free to come out as rock
$execute as @n[type=marker,tag=dr_seed,tag=!dr_chain,x=$(x),dx=12,y=-64,dy=384,z=$(z),dz=14] run function derailed:dev/gen/_join
