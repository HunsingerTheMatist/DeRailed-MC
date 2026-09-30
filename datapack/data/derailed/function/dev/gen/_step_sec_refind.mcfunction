
# Finds the second way again over the ticks after where it cut through rock,
#  then sets the rounds that open it up going
# Positioned at the section's corner

scoreboard players set #q_step dr_var 63
execute if score #gen_carved dr_var matches 0 run return 0
scoreboard players add #gen_cuts2 dr_var 1
scoreboard players set #q_find_ret dr_var 63
scoreboard players set #q_step dr_var 60
return 0
