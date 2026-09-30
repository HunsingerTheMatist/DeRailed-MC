
# Lays the second way worked out down and walks it back, then goes back to the
#  step '#q_find_ret' names
# Positioned at the section's corner

execute positioned ~ ~15 ~ run function derailed:dev/gen/_second_find_lay
scoreboard players operation #q_step dr_var = #q_find_ret dr_var
return 1
