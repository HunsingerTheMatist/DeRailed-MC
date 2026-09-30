
# Cuts the first river, then the second on the tick after where one is still to
#  be looked at
# Positioned at the section's corner

# A section whose rivers found nowhere to start goes on without them, counted
#  by the search, since nothing a reroll does can put a river into it
scoreboard players set #q_step dr_var 5
execute if score #gen_rivers dr_var matches 1 if function derailed:dev/gen/_rivers_a run scoreboard players set #q_step dr_var 52

# Held for a look at the river, nothing is drawn over it
execute if score #gen_riv_hold dr_var matches 1 run function derailed:dev/gen/_step_laid
return 1
