
# Clears the three by three blocks from $(x) $(y) $(z), $(h) blocks up past the
#  first, and builds the tile's columns there

$execute positioned $(x) $(y) $(z) run fill ~ ~ ~ ~2 ~$(h) ~2 air strict
$execute positioned $(x) $(y) $(z) run function derailed:dev/mound/_blocks
