
# Counts the tile $(x) $(z) from this corner against the side being tried if
#  it is a prefab's, or if the corner's column is $(minx) or less, which puts
#  the tile across the seam in the section before

$execute if block ~$(x) ~ ~$(z) #derailed:prefab run scoreboard players add #riv_bad dr_var 1
$execute if score #riv_cx dr_var matches ..$(minx) run scoreboard players add #riv_bad dr_var 1
