
# Lays out the seeds and the regions they grow
# Positioned at the section's corner, with the station laid

function derailed:dev/gen/scatter
function derailed:dev/gen/grow

# The regions as they grew are kept on a spare layer, for a section that has to
#  be built again from them
clone ~ ~ ~ ~31 ~ ~15 ~ ~12 ~ strict

scoreboard players set #q_step dr_var 3
return 1
