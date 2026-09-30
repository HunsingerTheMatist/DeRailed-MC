
# Checks the wood and iron within reach, a section usable so far, then goes on
#  to the order
# Positioned at the section's corner

scoreboard players set #q_step dr_var 15
execute unless score #gen_valid dr_var matches 1 run return 0
scoreboard players set #q_sup_ret dr_var 15
scoreboard players set #q_step dr_var 30
return 0
