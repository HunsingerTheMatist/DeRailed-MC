
# One round of opening the section up, '_pinch_open_round', then the route found
#  again over what was opened and the pinching measured afresh; returns 1 for
#  another round to be looked at
# Positioned at the section's corner

execute unless function derailed:dev/gen/_pinch_open_round run return 0
execute if score #cost_mode dr_var matches 0 run function derailed:dev/gen/_validate_pass
execute if score #cost_mode dr_var matches 1 run function derailed:dev/gen/_second_find
return 1
