
# Goes round the wave being taken again while any tile is still due on it,
#  which only a tile costing nothing can be, since it falls due on the very
#  wave that reached it

execute if score #gen_reached dr_var matches 1 run return 0

execute if score #cost_mod dr_var matches 0 unless entity @e[type=marker,tag=dr_f0,distance=0..] run return 0
execute if score #cost_mod dr_var matches 1 unless entity @e[type=marker,tag=dr_f1,distance=0..] run return 0
execute if score #cost_mod dr_var matches 2 unless entity @e[type=marker,tag=dr_f2,distance=0..] run return 0
execute if score #cost_mod dr_var matches 3 unless entity @e[type=marker,tag=dr_f3,distance=0..] run return 0
execute if score #cost_mod dr_var matches 4 unless entity @e[type=marker,tag=dr_f4,distance=0..] run return 0
execute if score #cost_mod dr_var matches 5 unless entity @e[type=marker,tag=dr_f5,distance=0..] run return 0
execute if score #cost_mod dr_var matches 6 unless entity @e[type=marker,tag=dr_f6,distance=0..] run return 0
execute if score #cost_mod dr_var matches 7 unless entity @e[type=marker,tag=dr_f7,distance=0..] run return 0

function derailed:dev/gen/_cost_sweep
function derailed:dev/gen/_cost_sweep_more
