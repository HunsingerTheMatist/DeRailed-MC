
# Tags the pinched cells within two tiles of either end of the route,
#  'dr_pinch_near_in' by the entry tile and 'dr_pinch_near_out' by a tile the
#  track's last rail may lie on, then tags 'dr_pinch_edge' every cell of each
#  run holding one, and counts those in '#pinch_edges'
# Takes the rows from 'r'
# Positioned at the section's corner

tag @e[type=marker,tag=dr_pinch_edge,distance=0..] remove dr_pinch_edge
tag @e[type=marker,tag=dr_pinch_near_in,distance=0..] remove dr_pinch_near_in
tag @e[type=marker,tag=dr_pinch_near_out,distance=0..] remove dr_pinch_near_out
$execute positioned ~ ~ ~$(entry) run tag @e[type=marker,tag=dr_pinch,distance=..2.1] add dr_pinch_near_in
$execute positioned ~$(goal) ~ ~$(exit) run tag @e[type=marker,tag=dr_pinch,distance=..2.1] add dr_pinch_near_out
$execute if score #gen_station dr_var matches 1 positioned ~29 ~ ~$(low) run tag @e[type=marker,tag=dr_pinch,distance=..2.1] add dr_pinch_near_out
execute as @e[type=marker,tag=dr_pinch_near_in,distance=0..] run function derailed:dev/gen/_pinch_edge_run
execute as @e[type=marker,tag=dr_pinch_near_out,distance=0..] run function derailed:dev/gen/_pinch_edge_run
execute store result score #pinch_edges dr_var if entity @e[type=marker,tag=dr_pinch_edge,distance=0..]
