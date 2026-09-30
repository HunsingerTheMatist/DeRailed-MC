
# Ends the second route's search, then goes on to drawing it
# Positioned at the section's corner

execute positioned ~ ~15 ~ run function derailed:dev/gen/_second_search_b
scoreboard players set #q_step dr_var 46
return 0
