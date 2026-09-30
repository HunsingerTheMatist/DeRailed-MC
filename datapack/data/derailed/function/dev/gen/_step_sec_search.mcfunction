
# Readies working out the second way round the first route's pinches, then
#  works it out over the ticks after and finds it again over what it cut
# Positioned at the section's corner

scoreboard players set #cost_mode dr_var 1
execute positioned ~ ~15 ~ run function derailed:dev/gen/_sec_prepare
scoreboard players set #q_find_ret dr_var 51
scoreboard players set #q_step dr_var 60
return 1
