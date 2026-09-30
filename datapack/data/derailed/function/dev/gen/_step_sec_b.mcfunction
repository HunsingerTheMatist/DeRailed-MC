
# Draws the second route, then goes back to the step '#q_sec_ret' names
# Positioned at the section's corner

execute positioned ~ ~15 ~ run function derailed:dev/gen/_second_b
scoreboard players operation #q_step dr_var = #q_sec_ret dr_var
return 1
