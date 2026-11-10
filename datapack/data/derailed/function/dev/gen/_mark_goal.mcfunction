
# Marks the tiles the track's last rail may lie on, as the ones the flood is
#  trying to reach: the tile it leaves on, or before a station either of the
#  two tiles beside the station's first rail, west of it and south of it, since
#  the track may come onto the rail from both
# The station's own rails count as seen already, so no route ever runs over
#  them, and so do the first section's start station's buffer stop and seven
#  rails
# Takes $(goal), the column of the tile west of the first rail, $(exit), the
#  row the track leaves on, $(low), the row south of it, and $(entry), the row
#  the track enters on

$setblock ~$(goal) ~2 ~$(exit) gold_block strict
$execute if score #gen_station dr_var matches 1 run setblock ~29 ~2 ~$(low) gold_block strict
$execute if score #gen_station dr_var matches 1 run fill ~29 ~2 ~$(exit) ~31 ~2 ~$(exit) gray_stained_glass strict
$execute if score #gen_station dr_var matches 1 if score #gen_section dr_var matches 0 run fill ~ ~2 ~$(entry) ~7 ~2 ~$(entry) gray_stained_glass strict
