
# Searches out the second way, then finds it again over what it cut on the tick
#  after
# Positioned at the section's corner

execute positioned ~ ~15 ~ run function derailed:dev/gen/_second_search_a
scoreboard players set #q_step dr_var 51
return 1
