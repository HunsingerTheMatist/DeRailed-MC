
# Opens the pinched cells of the first route within two tiles of either end of
#  it, since a pinch there can leave the second route no way off the tile both
#  routes share, then finds and judges the first route again and looks for the
#  second once more
# Does nothing where no run lies against an end
# Positioned at the section's corner, on the visible layer

# The first route is found again to mark its pinched cells, which the search
#  for the second has cleared; nothing on the ground has changed since, since a
#  second route that was never found cut nothing
scoreboard players set #cost_mode dr_var 0
function derailed:dev/gen/_validate_pass
function derailed:dev/gen/_pinch_ends with storage derailed:gen r
execute if score #pinch_edges dr_var matches 0 run return 0

scoreboard players add #gen_ends_opened dr_var 1
function derailed:dev/gen/_pinch_open_edges
function derailed:dev/gen/_validate_pass
scoreboard players set #pinch_rounds dr_var 4
function derailed:dev/gen/_pinch_relieve
function derailed:dev/gen/_validate_judge

# Opening the ends can take a section under its floor or its band, which is
#  then a reroll like any other and counted the same way
execute if score #gen_reached dr_var matches 1 if score #gen_rate_free dr_var matches 0 if score #gen_rate dr_var < #gen_rate_min dr_var run scoreboard players add #gen_fail_cheap dr_var 1
execute if score #gen_reached dr_var matches 1 if score #gen_pinch dr_var < #gen_pinch_min dr_var run scoreboard players add #gen_fail_flat dr_var 1

# The search that found nothing is counted again if this one finds nothing too
scoreboard players remove #gen_no_second dr_var 1
function derailed:dev/gen/second
