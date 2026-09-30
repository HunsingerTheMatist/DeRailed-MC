
# Works out the second way across along the first route, a stretch at a time,
#  and returns 1 where there is one, for '_second_find_lay' to lay down; where
#  there is none, leaves '#gen_reached' at 0
# Positioned at the section's corner, with the first route's tiles marked,
#  the first route and its band and zone three above, and '#cost_mode' at 1

scoreboard players set #sec_fb dr_var 0
function derailed:dev/gen/_sec_dp
execute if score #sec_paused dr_var matches 1 run return 0
return run function derailed:dev/gen/_second_find_dp_end
