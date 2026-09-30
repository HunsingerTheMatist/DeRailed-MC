
# Takes one round of opening the section up, on the first route where
#  '#q_relief_mode' is 0 and on the second where it is 1, another on the tick
#  after while rounds are wanted, then goes on to the step '#q_relief_ret' names
# Positioned at the section's corner

scoreboard players operation #cost_mode dr_var = #q_relief_mode dr_var
execute positioned ~ ~15 ~ if function derailed:dev/gen/_pinch_round run return 1
scoreboard players operation #q_step dr_var = #q_relief_ret dr_var
return 0
