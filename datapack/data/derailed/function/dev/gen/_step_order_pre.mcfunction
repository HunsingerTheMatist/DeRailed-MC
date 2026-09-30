
# A first route the players run out of wood on partway, with no region the
#  order's fix could make wood, is a reroll straight away while
#  '#gen_order_reroll' says so, before the second way and the supply are
#  looked for
# Positioned at the section's corner

scoreboard players set #q_step dr_var 12
scoreboard players set #opre dr_var 0
execute unless score #gen_valid dr_var matches 1 run return 0
execute unless score #gen_order_reroll dr_var matches 1 run return 0
execute positioned ~ ~15 ~ run function derailed:dev/gen/_order_pre
execute if score #opre dr_var matches 1 run scoreboard players add #gen_fail_order dr_var 1
execute if score #opre dr_var matches 1 run scoreboard players set #gen_valid dr_var 0
return 1
