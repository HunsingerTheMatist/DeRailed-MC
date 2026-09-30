
# Starts the supply check, then goes on to the repair's steps, or straight back
#  to the step '#q_sup_ret' names where the track never got across
# Positioned at the section's corner

scoreboard players set #q_step dr_var 31
execute positioned ~ ~15 ~ unless function derailed:dev/gen/_supply_a run scoreboard players operation #q_step dr_var = #q_sup_ret dr_var
return 1
