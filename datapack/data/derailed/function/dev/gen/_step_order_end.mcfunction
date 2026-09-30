
# Counts an order that still fails once the fixes are done as a reroll, while
#  '#gen_order_reroll' says so
# Positioned at the section's corner

execute if score #gen_order_reroll dr_var matches 1 if score #gen_valid dr_var matches 1 if score #order_ok dr_var matches 0 run scoreboard players add #gen_fail_order dr_var 1
execute if score #gen_order_reroll dr_var matches 1 if score #order_ok dr_var matches 0 run scoreboard players set #gen_valid dr_var 0
scoreboard players set #q_step dr_var 16
return 0
