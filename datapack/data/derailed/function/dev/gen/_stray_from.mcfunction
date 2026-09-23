
# Copies the tile $(x) $(z) away onto this one, on the kinds layer and the base
#  both, and puts light blue glass over it so the copying can be picked out from
#  above
# Positioned on the tile

$clone ~$(x) ~5 ~$(z) ~$(x) ~5 ~$(z) ~ ~5 ~ strict
clone ~ ~5 ~ ~ ~5 ~ ~ ~ ~ strict
setblock ~ ~16 ~ light_blue_stained_glass strict
scoreboard players add #stray_n dr_var 1
