
# Joins the nearest free seed between this one and the exit row
# Takes $(x), $(z) and $(dz), the window's near face, near edge and depth

$execute as @n[type=marker,tag=dr_seed,tag=!dr_chain,x=$(x),dx=40,y=-64,dy=384,z=$(z),dz=$(dz)] run function derailed:dev/gen/_join_tail
