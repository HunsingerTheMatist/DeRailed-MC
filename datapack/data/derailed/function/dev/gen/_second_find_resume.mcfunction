
# Picks working out the second way up again where it paused, and returns 1
#  where it has ended with a way found
# Positioned at the section's corner

function derailed:dev/gen/_sec_dp_resume
execute if score #sec_paused dr_var matches 1 run return 0
return run function derailed:dev/gen/_second_find_dp_end
