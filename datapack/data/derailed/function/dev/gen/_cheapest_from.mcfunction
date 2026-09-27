
# Counts the rails of the way the flood found back from the tile the track's
#  last rail lies on, which before a station is whichever of the two tiles
#  beside its first rail the flood took
# Takes $(goal), the column of the tile west of the first rail, $(exit), the
#  row the track leaves on, and $(low), the row south of it

$execute if block ~$(goal) ~2 ~$(exit) #derailed:flood_arrows positioned ~$(goal) ~ ~$(exit) run return run function derailed:dev/gen/_cheapest_walk
$execute if score #gen_station dr_var matches 1 positioned ~29 ~ ~$(low) run function derailed:dev/gen/_cheapest_walk
