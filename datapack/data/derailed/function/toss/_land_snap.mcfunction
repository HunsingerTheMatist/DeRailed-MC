# Puts a pile down on the floor here, whatever stands there: the block here
#  where a pile could not stand in it, a slab or more, and the block under it
#  otherwise
# Run as the thrown display, at the bottom middle of the block it is in

execute unless block ~ ~ ~ #derailed:valid_placements run return run function derailed:toss/_land_on
execute positioned ~ ~-1 ~ run function derailed:toss/_land_on
