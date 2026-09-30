
# Ends the supply check, then goes back to the step '#q_sup_ret' names
# Positioned at the section's corner

execute positioned ~ ~15 ~ run function derailed:dev/gen/_supply_c
scoreboard players operation #q_step dr_var = #q_sup_ret dr_var
return 1
