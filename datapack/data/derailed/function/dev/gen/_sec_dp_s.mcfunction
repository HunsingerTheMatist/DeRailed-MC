
# Settles where stretch '#sec_s' is joined and what that cost, and where it was
#  reached at all searches off the route from it for every later stretch,
#  then goes on to the next stretch
# Positioned at the section's corner

execute if score #sec_s dr_var > #sec_last dr_var run return 0

function derailed:dev/gen/_sec_pick
execute if score #sec_bs dr_var < #sec_inf dr_var if score #sec_s dr_var < #sec_last dr_var run function derailed:dev/gen/_sec_search_from

scoreboard players add #sec_s dr_var 1
function derailed:dev/gen/_sec_dp_s
