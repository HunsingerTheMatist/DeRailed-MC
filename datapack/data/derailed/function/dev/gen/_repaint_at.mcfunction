
# Makes this tile $(kind) if it belongs to region $(id), as it grew or by a cut
#  that took the region's terrain, on the kinds layer and the visible layer
#  both, unless the river runs over it, and marks it
# Positioned on the tile, with the regions cuts gave tiles two below and the
#  regions as they grew fifteen below

$execute if block ~ ~-15 ~ $(id) unless block ~ ~ ~ light_blue_concrete run setblock ~ ~-10 ~ $(kind) strict
$execute if block ~ ~-15 ~ $(id) unless block ~ ~ ~ light_blue_concrete run setblock ~ ~1 ~ magenta_stained_glass strict
$execute if block ~ ~-15 ~ $(id) unless block ~ ~ ~ light_blue_concrete run setblock ~ ~ ~ $(kind) strict
$execute if block ~ ~-2 ~ $(id) unless block ~ ~ ~ light_blue_concrete run setblock ~ ~-10 ~ $(kind) strict
$execute if block ~ ~-2 ~ $(id) unless block ~ ~ ~ light_blue_concrete run setblock ~ ~1 ~ magenta_stained_glass strict
$execute if block ~ ~-2 ~ $(id) unless block ~ ~ ~ light_blue_concrete run setblock ~ ~ ~ $(kind) strict
