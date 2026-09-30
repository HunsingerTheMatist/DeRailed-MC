
# Opens the ends of the first route and finds it again, then opens it up a round
#  a tick; with no run against an end, on past the second way
# Positioned at the section's corner

scoreboard players set #q_step dr_var 49
execute positioned ~ ~15 ~ unless function derailed:dev/gen/_second_retry_a run return 1
scoreboard players set #q_relief_mode dr_var 0
scoreboard players set #q_relief_ret dr_var 50
scoreboard players set #q_step dr_var 40
return 1
