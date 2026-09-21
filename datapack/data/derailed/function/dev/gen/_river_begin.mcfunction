
# Puts a head on this corner and sets the search going from it, unless this is a
#  start already tried
# Positioned on the corner, with '#riv_dir' facing inward
# The start is marked whether anything comes of it or not, so a corner that leads
#  nowhere is not rolled again

execute if entity @n[type=marker,tag=dr_riv_seed,distance=..0.4] run return fail

summon marker ~ ~ ~ {Tags:["dr_riv_seed"]}
execute summon marker run function derailed:dev/gen/_river_head

execute as @e[type=marker,tag=dr_riv_head,distance=0..] at @s run function derailed:dev/gen/_river_open
