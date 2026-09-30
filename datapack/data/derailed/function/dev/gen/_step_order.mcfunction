
# Checks that the players can get their wood in order, sending the section on
#  to the order's fix where they cannot and fixes are left
# Positioned at the section's corner

# The players have to be able to get their wood in order, every bridge paid for
#  with wood they can already reach; where they cannot, a region they reach in
#  time is repainted as wood and the supply checked again, up to
#  '#gen_order_fixes' times, and a section still failing is a reroll while
#  '#gen_order_reroll' says so
scoreboard players set #order_ok dr_var 1
scoreboard players operation #ofix_left dr_var = #gen_order_fixes dr_var
scoreboard players set #q_step dr_var 35
execute unless score #gen_valid dr_var matches 1 run return 0
execute positioned ~ ~15 ~ run function derailed:dev/gen/_order
execute if score #order_ok dr_var matches 0 if score #ofix_left dr_var matches 1.. run scoreboard players set #q_step dr_var 33
return 1
