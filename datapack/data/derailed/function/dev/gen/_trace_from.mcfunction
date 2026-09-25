
# Walks the route back from the tile the track's last rail lies on
# Before a station that is whichever of the two tiles beside its first rail
#  the flood took, the one west of it or the one south of it, told by the
#  arrow the flood left on it; and the train runs on from that rail onto the
#  station's first, so the box standing on the two of them is judged before
#  the walk, from the station's rail with the last rail behind it
# Takes $(goal), the column of the tile west of the first rail, $(exit), the
#  row the track leaves on, and $(low), the row south of it

$execute if score #gen_station dr_var matches 1 if block ~$(goal) ~2 ~$(exit) #derailed:flood_arrows run function derailed:dev/gen/_pinch_onto {x:29,z:$(exit),back:1}
$execute if score #gen_station dr_var matches 1 unless block ~$(goal) ~2 ~$(exit) #derailed:flood_arrows run function derailed:dev/gen/_pinch_onto {x:29,z:$(exit),back:4}

$execute if block ~$(goal) ~2 ~$(exit) #derailed:flood_arrows run return run function derailed:dev/gen/_trace_at {x:$(goal),z:$(exit)}
$execute if score #gen_station dr_var matches 1 run function derailed:dev/gen/_trace_at {x:29,z:$(low)}
