
# Marks a rock tile on the route to be cut, numbered along the route from the
#  exit end, so that the cut can be filled in once the whole of it is known
# Positioned on the tile

scoreboard players add #cut_n dr_var 1
execute summon marker run function derailed:dev/gen/_cut_marked
