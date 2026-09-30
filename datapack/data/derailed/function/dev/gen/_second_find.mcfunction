
# Finds the second way across along the first route: it walks the first route
#  and leaves it only to get round a pinch, by the detours that cut the least
#  rock and then run the fewest tiles, none more than '#gen_detour_max' tiles
#  off the route; then lays it down as a flood's arrows and walks it back like
#  any route, which measures it, marks what it cuts and draws it
# Leaves '#gen_reached' at 0 where no such way exists
# Positioned at the section's corner, with the first route's tiles marked,
#  the first route and its band and zone three above, and '#cost_mode' at 1

scoreboard players set #sec_slice dr_var 0
function derailed:dev/gen/_second_find_dp
function derailed:dev/gen/_second_find_wait
execute if score #sec_found dr_var matches 1 run function derailed:dev/gen/_second_find_lay
