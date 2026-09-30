
# Cuts a river along the boundaries between regions, in from one border and out
#  by the other, and a second beside it when the first came up short, allowed to
#  end in the first
# Positioned at the section's corner

scoreboard players set #riv_slice dr_var 0
function derailed:dev/gen/_rivers_a_pre
function derailed:dev/gen/_river_one
function derailed:dev/gen/_river_walk_all
execute unless function derailed:dev/gen/_rivers_a_post run return 0
execute unless function derailed:dev/gen/_rivers_b_pre run return 0
scoreboard players set #riv_slice dr_var 0
function derailed:dev/gen/_river_one
function derailed:dev/gen/_river_walk_all
function derailed:dev/gen/_rivers_b_post
