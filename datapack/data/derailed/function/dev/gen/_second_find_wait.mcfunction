
# Picks working out the second way up again until it has ended
# Positioned at the section's corner

execute if score #sec_paused dr_var matches 1 run function derailed:dev/gen/_second_find_resume
execute if score #sec_paused dr_var matches 1 run function derailed:dev/gen/_second_find_wait
