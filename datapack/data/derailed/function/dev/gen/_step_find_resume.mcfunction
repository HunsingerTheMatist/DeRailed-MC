
# Picks working out the second way up again for another share of its searches,
#  on the tick after while it is not done, then lays it down where one is found
#  or goes back to the step '#q_find_ret' names
# Positioned at the section's corner

scoreboard players operation #q_step dr_var = #q_find_ret dr_var
execute positioned ~ ~15 ~ if function derailed:dev/gen/_second_find_resume run scoreboard players set #q_step dr_var 62
execute if score #sec_paused dr_var matches 1 run scoreboard players set #q_step dr_var 61
return 1
