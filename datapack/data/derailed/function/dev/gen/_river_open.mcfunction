
# Sets the search going if any boundary runs from this corner
# Run as the head, positioned on it: the reckoning needs a real entity to read a
#  position from, which is why the head is stood up before it is asked

# Only straight inward can be open from a border corner, since the two ways along
#  the border have air on their far side, but the reckoning answers for all three
#  and there is nothing to gain by asking it for less
function derailed:dev/gen/_river_look
scoreboard players operation #riv_tot dr_var = #riv_v0 dr_var
scoreboard players operation #riv_tot dr_var += #riv_v1 dr_var
scoreboard players operation #riv_tot dr_var += #riv_v2 dr_var
execute if score #riv_tot dr_var matches 0 run return run kill @s

scoreboard players remove #riv_tries dr_var 1
scoreboard players set #riv_depth dr_var 0
scoreboard players set #riv_step dr_var 0

function derailed:dev/gen/_river_lay
