
# Counts a section left with no second way as a reroll, while
#  '#gen_second_reroll' says so, then goes on to the cheapest way across
# Positioned at the section's corner

execute if score #gen_second_reroll dr_var matches 1 if score #gen_valid dr_var matches 1 if score #sec_reached dr_var matches 0 run scoreboard players add #gen_fail_second dr_var 1
execute if score #gen_second_reroll dr_var matches 1 if score #sec_reached dr_var matches 0 run scoreboard players set #gen_valid dr_var 0
scoreboard players set #q_step dr_var 13
return 0
