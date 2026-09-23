
# Joins the nearest seed in the window that is not on the band already
# Takes $(x), the west face of the window, and $(z), its north edge

$execute as @n[type=marker,tag=dr_seed,tag=!dr_wall,x=$(x),dx=12,y=-64,dy=384,z=$(z),dz=8] run function derailed:dev/gen/_wall_join
