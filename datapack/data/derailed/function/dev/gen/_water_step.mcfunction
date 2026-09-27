
# Steps onto the tile $(x) $(z) away where it is land not yet reached, marking
#  it one layer down and setting out from it next
# Positioned on the tile stepped from

$execute unless block ~$(x) ~-1 ~$(z) air run return 0
$execute unless block ~$(x) ~ ~$(z) #derailed:land run return 0
$setblock ~$(x) ~-1 ~$(z) lime_stained_glass strict
$execute positioned ~$(x) ~ ~$(z) summon marker run function derailed:dev/gen/_water_new
