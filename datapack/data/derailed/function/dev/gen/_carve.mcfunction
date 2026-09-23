
# Cuts this rock tile out of the route, making it whatever terrain other than
#  rock is nearest, so that the passage reads as a gap in the rock rather than a
#  strip of something new
# The kinds layer takes the cut as well, since it is what the finished section
#  is laid out from
# Positioned on the tile

function derailed:dev/gen/_carve_pick
clone ~ ~ ~ ~ ~ ~ ~ ~-10 ~ strict
