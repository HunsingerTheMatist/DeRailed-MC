
# Opens the section up until the train is pinched no more than the tier allows,
#  a round at a time: the longest run is opened along one side, the route found
#  again over what was opened, and the pinching measured afresh
# Positioned at the section's corner

execute if score #gen_pinch dr_var <= #gen_pinch_max dr_var run return 0
execute if score #pinch_rounds dr_var matches ..0 run return fail
scoreboard players remove #pinch_rounds dr_var 1

function derailed:dev/gen/_pinch_open
execute if score #cost_mode dr_var matches 0 run function derailed:dev/gen/_validate_pass
execute if score #cost_mode dr_var matches 1 run function derailed:dev/gen/_second_pass
function derailed:dev/gen/_pinch_relieve
