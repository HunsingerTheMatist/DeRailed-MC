
# Opens the section up until the train is pinched no more than the tier allows,
#  a round at a time: a run of the first route lying against either end of it
#  is opened first where there is one, from that end, since a pinch there can
#  leave no way round the train at all, and otherwise the longest run, from
#  its exit end, each only as far as brings the section under its ceiling;
#  then the route is found again over what was opened, and the pinching
#  measured afresh
# Positioned at the section's corner

execute if score #gen_pinch dr_var <= #gen_pinch_max dr_var run return 0
execute if score #pinch_rounds dr_var matches ..0 run return fail
scoreboard players remove #pinch_rounds dr_var 1

# An end run whose rock cannot be cut, where it stands against the station or
#  the section before, is passed over for the longest run
scoreboard players set #pinch_edges dr_var 0
scoreboard players operation #pinch_was dr_var = #gen_opened dr_var
scoreboard players operation #pinch_top_was dr_var = #pinch_top dr_var
scoreboard players operation #pinch_top_id_was dr_var = #pinch_top_id dr_var
execute if score #cost_mode dr_var matches 0 run function derailed:dev/gen/_pinch_ends with storage derailed:gen r
execute if score #pinch_edges dr_var matches 1.. run function derailed:dev/gen/_pinch_open_edge
execute if score #pinch_edges dr_var matches 1.. if score #gen_opened dr_var = #pinch_was dr_var run scoreboard players set #pinch_edges dr_var 0
scoreboard players operation #pinch_top dr_var = #pinch_top_was dr_var
scoreboard players operation #pinch_top_id dr_var = #pinch_top_id_was dr_var
execute if score #pinch_edges dr_var matches 0 run function derailed:dev/gen/_pinch_open

execute if score #cost_mode dr_var matches 0 run function derailed:dev/gen/_validate_pass
execute if score #cost_mode dr_var matches 1 run function derailed:dev/gen/_second_pass
function derailed:dev/gen/_pinch_relieve
