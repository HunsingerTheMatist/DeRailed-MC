
# Copies the tile $(x) $(z) away onto this one and gives this tile its region:
#  the region the copy was given where it is a cut tile itself, none yet where
#  it is a cut tile given none, and otherwise the region it grew as
# A cut tile's region is kept thirteen above the regions as they grew, which is
#  cleared at the start of every attempt, since the cuts are the attempt's
# Positioned on the tile, on the visible layer

$clone ~$(x) ~ ~$(z) ~$(x) ~ ~$(z) ~ ~ ~ strict
$execute unless block ~$(x) ~-2 ~$(z) air run return run clone ~$(x) ~-2 ~$(z) ~$(x) ~-2 ~$(z) ~ ~-2 ~ strict
$execute positioned ~$(x) ~ ~$(z) if entity @n[type=marker,tag=dr_cut,distance=..0.4] run return 0
$clone ~$(x) ~-15 ~$(z) ~$(x) ~-15 ~$(z) ~ ~-2 ~ strict
