
# Runs steps of the section being built until one does real work or the section
#  is done
# Positioned at the section's corner

execute if function derailed:dev/gen/_q_do run return 0
execute if score #q_step dr_var matches 1.. run function derailed:dev/gen/_q_tick_step
