
# Gives this cut tile the region of the tile $(x) $(z) away, where that tile is
#  the same terrain: the region it was given where it is a cut tile, and
#  otherwise the region it grew as, a cut tile given none having none to give
# Positioned on the tile, on the visible layer

$execute unless blocks ~$(x) ~ ~$(z) ~$(x) ~ ~$(z) ~ ~ ~ all run return fail
$execute unless block ~$(x) ~-2 ~$(z) air run return run clone ~$(x) ~-2 ~$(z) ~$(x) ~-2 ~$(z) ~ ~-2 ~ strict
$execute positioned ~$(x) ~ ~$(z) if entity @n[type=marker,tag=dr_cut,distance=..0.4] run return fail
$clone ~$(x) ~-15 ~$(z) ~$(x) ~-15 ~$(z) ~ ~-2 ~ strict
