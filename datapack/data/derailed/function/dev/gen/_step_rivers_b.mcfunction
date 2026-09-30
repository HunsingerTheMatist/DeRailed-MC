
# Sets the second river up where one is wanted and walks it for a share of
#  steps, going on to walk it further on the ticks after where it pauses, then
#  to its end
# Positioned at the section's corner

scoreboard players set #q_step dr_var 5
execute unless function derailed:dev/gen/_rivers_b_pre run return 0
scoreboard players set #riv_slice dr_var 0
function derailed:dev/gen/_river_one
scoreboard players set #q_river_ret dr_var 56
scoreboard players set #q_step dr_var 56
execute if score #riv_paused dr_var matches 1 run scoreboard players set #q_step dr_var 54
return 1
