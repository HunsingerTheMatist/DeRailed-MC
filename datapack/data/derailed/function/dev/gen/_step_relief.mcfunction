
# Opens the section up a round, on the first route where '#q_relief_mode' is 0
#  and on the second where it is 1, and finds the route again, another round
#  on the tick after while rounds are wanted, then goes on to the step
#  '#q_relief_ret' names
# Positioned at the section's corner

scoreboard players operation #cost_mode dr_var = #q_relief_mode dr_var
scoreboard players set #q_w dr_var 0
execute positioned ~ ~15 ~ if function derailed:dev/gen/_pinch_open_round run scoreboard players set #q_w dr_var 1
execute if score #q_w dr_var matches 0 run scoreboard players operation #q_step dr_var = #q_relief_ret dr_var
execute if score #q_w dr_var matches 0 run return 0

# The first route is found again on the same tick, the second over the ticks
#  after
execute if score #q_relief_mode dr_var matches 0 positioned ~ ~15 ~ run function derailed:dev/gen/_validate_pass
execute if score #q_relief_mode dr_var matches 0 run return 1
scoreboard players set #q_find_ret dr_var 40
scoreboard players set #q_step dr_var 60
return 1
