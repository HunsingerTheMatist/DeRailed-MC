
# Opens the pinched cells of the first route within two tiles of either end of
#  it, since a pinch there can leave the second route no way off the tile both
#  routes share, then finds the first route again, setting the rounds that open
#  it up going; returns 0, doing nothing, where no run lies against an end
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
return 1
