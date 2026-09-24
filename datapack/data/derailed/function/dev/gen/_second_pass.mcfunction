
# Floods from the entry tile to the exit tile for the second route, walks it
#  back, and cuts out any rock it ran through, keeping off every cell of the
#  first route where the train is pinched
# Positioned at the section's corner, with the first route and its band three
#  above and '#cost_mode' at 1

fill ~ ~2 ~ ~31 ~2 ~15 air strict

# The western column and the ring round the section, as for the first route
fill ~ ~2 ~ ~ ~2 ~15 gray_stained_glass strict
fill ~-1 ~2 ~-1 ~-1 ~2 ~16 gray_stained_glass replace air strict
fill ~32 ~2 ~-1 ~32 ~2 ~16 gray_stained_glass replace air strict
fill ~-1 ~2 ~-1 ~32 ~2 ~-1 gray_stained_glass replace air strict
fill ~-1 ~2 ~16 ~32 ~2 ~16 gray_stained_glass replace air strict

# The pinched cells of the first route count as seen already, so the flood
#  never steps onto them; the tiles at its two ends are marked over after, so
#  those two are always open
clone ~ ~3 ~ ~31 ~3 ~15 ~ ~2 ~ strict filtered gray_stained_glass

function derailed:dev/gen/_mark_goal with storage derailed:gen r
function derailed:dev/gen/_cost_from with storage derailed:gen r

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
scoreboard players set #pinch_pl dr_var 0
scoreboard players set #pinch_pr dr_var 0
scoreboard players set #pinch_pback dr_var 0

execute if score #gen_reached dr_var matches 1 run function derailed:dev/gen/_trace_from with storage derailed:gen r
function derailed:dev/gen/_pinch_close

execute if score #cut_n dr_var matches 1.. run function derailed:dev/gen/_cut_resolve

# The arrows and the cells counted as seen go once the route is drawn
fill ~ ~2 ~ ~31 ~2 ~15 air replace #derailed:flood_arrows strict
fill ~ ~2 ~ ~31 ~2 ~15 air replace gray_stained_glass strict
