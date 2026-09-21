
# Nothing reaches a border from this start, so the search gives it up
# A section picking up from the one before has nowhere else it may start, so it
#  settles for the longest it managed rather than going without

execute if score #riv_forced dr_var matches 1 if score #riv_best dr_var matches 1.. run function derailed:dev/gen/_river_settle
function derailed:dev/gen/_river_wipe
