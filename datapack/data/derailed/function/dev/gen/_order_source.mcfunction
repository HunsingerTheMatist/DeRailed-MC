
# Stands the flood on the tile the track comes in on, where the players start
# Takes $(entry), the row the track enters on, and $(start), the column of its
#  first tile
# Positioned at the section's corner

$execute positioned ~$(start) ~ ~$(entry) run setblock ~ ~2 ~ white_stained_glass strict
$execute positioned ~$(start) ~ ~$(entry) run summon marker ~ ~ ~ {Tags:["dr_flood","dr_f0"]}
