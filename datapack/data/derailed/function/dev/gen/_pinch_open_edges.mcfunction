
# Opens, run by run, the cells of every run tagged 'dr_pinch_edge' that lie
#  within two tiles of the end of the route the run lies against
# Positioned at the section's corner

execute unless entity @e[type=marker,tag=dr_pinch_edge,distance=0..] run return 0
scoreboard players set #pinch_near dr_var 1
function derailed:dev/gen/_pinch_open_edge
scoreboard players set #pinch_near dr_var 0
function derailed:dev/gen/_pinch_open_edges
