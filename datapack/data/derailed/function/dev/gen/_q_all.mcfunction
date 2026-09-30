
# Runs the section's steps one after another until it is done
# Positioned at the section's corner

function derailed:dev/gen/_q_do
execute if score #q_step dr_var matches 1.. run function derailed:dev/gen/_q_all
