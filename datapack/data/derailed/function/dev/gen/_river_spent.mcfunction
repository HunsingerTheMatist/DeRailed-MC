
# The search has used the whole budget it gets for this section

execute if score #riv_forced dr_var matches 1 if score #riv_best dr_var matches 1.. run function derailed:dev/gen/_river_settle
function derailed:dev/gen/_river_wipe
