
# Steps from this tile onto the land beside it that is not yet reached, then
#  is done with
# Run as the tile's marker, at it

function derailed:dev/gen/_water_step {x:1,z:0}
function derailed:dev/gen/_water_step {x:-1,z:0}
function derailed:dev/gen/_water_step {x:0,z:1}
function derailed:dev/gen/_water_step {x:0,z:-1}
kill @s
