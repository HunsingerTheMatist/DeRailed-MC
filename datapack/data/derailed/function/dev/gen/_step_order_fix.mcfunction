
# Makes one region wood for the order, then has the supply and the order checked
#  again; with no region to make wood, the order is left as it failed
# Positioned at the section's corner

scoreboard players set #q_step dr_var 35
execute positioned ~ ~15 ~ unless function derailed:dev/gen/_order_fix run return 1
scoreboard players set #q_sup_ret dr_var 34
scoreboard players set #q_step dr_var 30
return 1
