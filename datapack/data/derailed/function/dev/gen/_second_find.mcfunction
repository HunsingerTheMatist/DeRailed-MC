
# Finds the second way across along the first route: it walks the first route
#  and leaves it only to get round a pinch, by the detours that cut the least
#  rock and then run the fewest tiles, none more than '#gen_detour_max' tiles
#  off the route; then lays it down as a flood's arrows and walks it back like
#  any route, which measures it, marks what it cuts and draws it
# Leaves '#gen_reached' at 0 where no such way exists
# Positioned at the section's corner, with the first route's tiles marked,
#  the first route and its band and zone three above, and '#cost_mode' at 1

scoreboard players set #sec_fb dr_var 0
function derailed:dev/gen/_sec_dp
kill @e[type=marker,tag=dr_bq,distance=0..]

# The ways the searches kept are cleared once the way is laid, or at once
#  where there is none
scoreboard players operation #sec_y dr_var = #sec_last dr_var
scoreboard players add #sec_y dr_var 6
execute store result storage derailed:gen sk.top int 1 run scoreboard players get #sec_y dr_var

fill ~ ~2 ~ ~31 ~2 ~15 air strict
execute if score #sec_found dr_var matches 0 if score #sec_last dr_var matches 0.. run function derailed:dev/gen/_sec_keep_clear with storage derailed:gen sk
execute if score #sec_found dr_var matches 0 run return run scoreboard players set #gen_reached dr_var 0

function derailed:dev/gen/_sec_build
execute if score #sec_last dr_var matches 0.. run function derailed:dev/gen/_sec_keep_clear with storage derailed:gen sk
scoreboard players set #gen_reached dr_var 1

scoreboard players set #gen_route dr_var 0
scoreboard players set #gen_wet dr_var 0
scoreboard players set #gen_astray dr_var 0
scoreboard players set #gen_steps dr_var 400

kill @e[type=marker,tag=dr_cut_run,distance=0..]
scoreboard players set #cut_n dr_var 0
scoreboard players set #cut_runs dr_var 0
scoreboard players set #cut_open dr_var 0
scoreboard players set #cut_last dr_var -1

kill @e[type=marker,tag=dr_pinch,distance=0..]
scoreboard players set #gen_pinch dr_var 0
scoreboard players set #pinch_run dr_var 0
scoreboard players set #pinch_runs dr_var 0
scoreboard players set #pinch_seq dr_var 0
scoreboard players set #pinch_top dr_var 0
scoreboard players set #pinch_top_id dr_var 0

function derailed:dev/gen/_trace_from with storage derailed:gen r

# The way only counts as found where walking it back got all the way to the
#  entry, which the walk turns from white to red
function derailed:dev/gen/_sec_reached with storage derailed:gen r
function derailed:dev/gen/_pinch_close

execute if score #cut_n dr_var matches 1.. run function derailed:dev/gen/_cut_resolve

# The arrows go once the route is drawn; the ring stays as the section's
#  border to be looked at
fill ~ ~2 ~ ~31 ~2 ~15 air replace #derailed:flood_arrows strict
