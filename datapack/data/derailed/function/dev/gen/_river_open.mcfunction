
# Sets the search going if any boundary runs from this corner
# Run as the head, positioned on it: the reckoning needs a real entity to read a
#  position from, which is why the head is stood up before it is asked

# Any of the three ways on will do, not only straight inward: a corner on the
#  western border has the section before's terrain the other side of it rather
#  than air, though a way west is not allowed out of column 0
function derailed:dev/gen/_river_look
scoreboard players operation #riv_tot dr_var = #riv_v0 dr_var
scoreboard players operation #riv_tot dr_var += #riv_v1 dr_var
scoreboard players operation #riv_tot dr_var += #riv_v2 dr_var
execute if score #riv_tot dr_var matches 0 run return run kill @s

scoreboard players remove #riv_tries dr_var 1
scoreboard players set #riv_depth dr_var 0
scoreboard players set #riv_step dr_var 0

function derailed:dev/gen/_river_lay
