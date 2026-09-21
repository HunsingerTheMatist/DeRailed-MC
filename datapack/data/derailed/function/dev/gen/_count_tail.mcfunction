
# Counts the free seeds between this one and the exit row, never behind it
# Takes $(x), $(z) and $(dz), the window's near face, near edge and depth

$return run execute if entity @e[type=marker,tag=dr_seed,tag=!dr_chain,x=$(x),dx=40,y=-64,dy=384,z=$(z),dz=$(dz)]
