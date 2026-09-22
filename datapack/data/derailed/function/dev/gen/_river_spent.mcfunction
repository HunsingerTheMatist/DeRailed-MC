
# The search has used the whole budget of steps it gets for this river
# The line it was on may be the longest yet, and then it is cleared like any
#  other start that came to nothing

execute if score #riv_len dr_var > #riv_best dr_var run function derailed:dev/gen/_river_remember
function derailed:dev/gen/_river_wipe
