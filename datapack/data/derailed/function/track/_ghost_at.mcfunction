# Shows a ghost rail on the tile the clicked block is on, where it is a tile the
#  next rail could go on: the three by three columns round the block hold its
#  tile's middle and no other's, three blocks up or down
# Run at a point in the clicked block

execute align xyz positioned ~-1 ~-3 ~-1 as @e[type=marker,tag=dr_track_next,dx=2,dy=6,dz=2] at @s rotated as @s run \
    function derailed:track/_ghost_show
