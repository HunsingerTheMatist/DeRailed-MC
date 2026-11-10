
# Picks the three points of the first section's start station its ground grows
#  out from ('_start_spill', '_start_pick') and marks each with a marker tagged
#  'dr_start_mid' for seeds to keep their spacing from
# Positioned at the section's corner, which stands at z 0

function derailed:dev/gen/_start_pick

execute store result storage derailed:gen v.x int 1 run scoreboard players get #spill_x1 dr_var
execute store result storage derailed:gen v.z int 1 run scoreboard players get #spill_z1 dr_var
function derailed:dev/gen/_start_mid with storage derailed:gen v
execute store result storage derailed:gen v.x int 1 run scoreboard players get #spill_x2 dr_var
execute store result storage derailed:gen v.z int 1 run scoreboard players get #spill_z2 dr_var
function derailed:dev/gen/_start_mid with storage derailed:gen v
execute store result storage derailed:gen v.x int 1 run scoreboard players get #spill_x3 dr_var
execute store result storage derailed:gen v.z int 1 run scoreboard players get #spill_z3 dr_var
function derailed:dev/gen/_start_mid with storage derailed:gen v
