
# Checks the order again once the fix and the supply after it are done, and goes
#  round the fix again while it still fails and fixes are left
# Positioned at the section's corner

execute positioned ~ ~15 ~ run function derailed:dev/gen/_order
scoreboard players set #q_step dr_var 35
execute if score #order_ok dr_var matches 0 if score #ofix_left dr_var matches 1.. run scoreboard players set #q_step dr_var 33
return 1
