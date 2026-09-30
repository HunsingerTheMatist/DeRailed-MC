
# Starts working out the second way, a share of its searches a tick, lays it
#  down on the tick after it ends where one is found, then goes back to the
#  step '#q_find_ret' names
# Positioned at the section's corner

scoreboard players set #cost_mode dr_var 1
scoreboard players set #sec_slice dr_var 0
scoreboard players operation #q_step dr_var = #q_find_ret dr_var
execute positioned ~ ~15 ~ if function derailed:dev/gen/_second_find_dp run scoreboard players set #q_step dr_var 62
execute if score #sec_paused dr_var matches 1 run scoreboard players set #q_step dr_var 61
return 1
