
# A section with no second way whose first route is pinched against either end
#  has those pinches opened and the second way looked for again
# Positioned at the section's corner

scoreboard players set #q_step dr_var 49
execute if score #sec_ran dr_var matches 1 if score #sec_reached dr_var matches 0 run scoreboard players set #q_step dr_var 48
return 0
