
# Sets '#mf' where the tile $(x) $(z) away is '#mprev' deep; one past the ring
#  round the map is no tile and says nothing
# Positioned on the tile

$execute positioned ~$(x) ~ ~$(z) as @e[type=marker,tag=dr_mt,distance=..0.5] if score @s dr_md = #mprev dr_var run scoreboard players set #mf dr_var 1
