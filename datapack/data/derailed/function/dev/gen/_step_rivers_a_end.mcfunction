
# Takes what the first river came to, then goes on to the second where one is
#  still to be looked at, and to the stray sweep where not
# Positioned at the section's corner

scoreboard players set #q_step dr_var 5
execute if function derailed:dev/gen/_rivers_a_post run scoreboard players set #q_step dr_var 52

# Held for a look at the river, nothing is drawn over it
execute if score #gen_riv_hold dr_var matches 1 run function derailed:dev/gen/_step_laid
return 0
