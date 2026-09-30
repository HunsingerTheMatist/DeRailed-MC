
# Builds one whole section in one go, running the steps the queue runs a tick
#  apart one after another: laying it out, drawing the kinds again up to
#  '#gen_attempt_count' times until it passes every check, laying it again from
#  new seeds up to '#gen_fresh_max' times when those run out, and finishing it
# Positioned at the section's corner

scoreboard players set #q_step dr_var 1
function derailed:dev/gen/_q_all
