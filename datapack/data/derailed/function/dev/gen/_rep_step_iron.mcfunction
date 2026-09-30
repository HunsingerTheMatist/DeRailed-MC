
# Ends a step of the search: tries every change it may make toward iron, then
#  makes the best change found either way if it lowers the score, returning 1
#  where it made one
# Positioned at the section's corner, on the visible layer, while the supply
#  check's flood is still laid

scoreboard players set #rep_w dr_var 2
execute if score #rep_now_i dr_var matches 1.. run function derailed:dev/gen/_rep_try_kind

execute if score #rep_found dr_var matches 0 run return 0
function derailed:dev/gen/_rep_apply
return 1
