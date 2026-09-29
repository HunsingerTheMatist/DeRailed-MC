
# Brings '#mc' down to the depth of the tile $(x) $(z) from this corner
# Positioned at the corner, a layer above the tiles

$execute positioned ~$(x) ~-1 ~$(z) as @e[type=marker,tag=dr_mt,distance=..0.5] run scoreboard players operation #mc dr_var < @s dr_md
