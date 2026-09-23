
# Floods from the entry tile to the exit tile, walks the route back, and cuts
#  out any rock it ran through
# Positioned at the section's corner

# Tiles already reached are kept on a layer two above the section, so the flood
#  can tell where it has been
fill ~ ~2 ~ ~31 ~2 ~15 air strict

# The route may not run along the western column, where the station will
#  stand: every tile of it but the one the track comes in on counts as seen
#  already, and the start is stood on that one afterwards
fill ~ ~2 ~ ~ ~2 ~15 gray_stained_glass strict

# A ring of already-seen tiles around the section, so the flood stays inside it
#  rather than wandering into the section before
# Only the gaps are filled, since the section before left its own route along
#  that edge and it counts as already seen just as well
fill ~-1 ~2 ~-1 ~-1 ~2 ~16 gray_stained_glass replace air strict
fill ~32 ~2 ~-1 ~32 ~2 ~16 gray_stained_glass replace air strict
fill ~-1 ~2 ~-1 ~32 ~2 ~-1 gray_stained_glass replace air strict
fill ~-1 ~2 ~16 ~32 ~2 ~16 gray_stained_glass replace air strict

function derailed:dev/gen/_mark_goal with storage derailed:gen r
function derailed:dev/gen/_cost_from with storage derailed:gen r

# The way the flood came is still on the layer above, so the route it found can
#  be walked back from the exit
scoreboard players set #gen_route dr_var 0
scoreboard players set #gen_steps dr_var 400

# Rock on the route is gathered into runs as the trace goes, each knowing what
#  stands at its two ends, and nothing is left from the last time
kill @e[type=marker,tag=dr_cut_run,distance=0..]
scoreboard players set #cut_n dr_var 0
scoreboard players set #cut_runs dr_var 0
scoreboard players set #cut_open dr_var 0
scoreboard players set #cut_last dr_var -1

# How pinched the train is along the route is measured on the same walk, run
#  by run, and starts from nothing each time the route is found
kill @e[type=marker,tag=dr_pinch,distance=0..]
scoreboard players set #gen_pinch dr_var 0
scoreboard players set #pinch_run dr_var 0
scoreboard players set #pinch_runs dr_var 0
scoreboard players set #pinch_seq dr_var 0
scoreboard players set #pinch_top dr_var 0
scoreboard players set #pinch_top_id dr_var 0
scoreboard players set #pinch_pl dr_var 0
scoreboard players set #pinch_pr dr_var 0

execute if score #gen_reached dr_var matches 1 run function derailed:dev/gen/_trace_from with storage derailed:gen r
function derailed:dev/gen/_pinch_close

# Rock the route ran through is filled in once the whole route is known, since
#  which terrain a cut takes depends on what lies at either end of it
execute if score #cut_n dr_var matches 1.. run function derailed:dev/gen/_cut_resolve

# The arrows have done their work once the route is drawn, so they go, and the
#  western column with them, and what stays on the layer is the route alone
fill ~ ~2 ~ ~31 ~2 ~15 air replace #derailed:flood_arrows strict
fill ~ ~2 ~ ~ ~2 ~15 air replace gray_stained_glass strict
