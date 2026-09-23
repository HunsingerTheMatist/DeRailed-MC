
# Checks the track can get from the entry row to the exit row without crossing
#  rock, and that the cheapest way across costs neither too little nor too much
#  a rail
# Leaves '#gen_valid' at 1 when the section is usable
# Positioned at the section's corner

# Tiles already reached are kept on a layer two above the section, so the flood
#  can tell where it has been
fill ~ ~2 ~ ~31 ~2 ~15 air strict

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
execute if score #gen_reached dr_var matches 1 run function derailed:dev/gen/_trace_from with storage derailed:gen r

# The arrows have done their work once the route is drawn, so they go, and what
#  stays on the layer is the route alone
fill ~ ~2 ~ ~31 ~2 ~15 air replace #derailed:flood_arrows strict

# The route is judged by what it costs a rail, since the time the players get is
#  the rails they lay, so a longer way across is not a harder one on its own
# Kept in hundredths of a point a rail, so that it stays a whole number
scoreboard players set #gen_rate_raw dr_var 0
execute if score #gen_route dr_var matches 1.. run scoreboard players operation #gen_rate_raw dr_var = #gen_cost dr_var
execute if score #gen_route dr_var matches 1.. run scoreboard players operation #gen_rate_raw dr_var *= $Hundred dr_const
execute if score #gen_route dr_var matches 1.. run scoreboard players operation #gen_rate_raw dr_var /= #gen_route dr_var

# Then raised a little for every rail past a straight crossing, since a longer
#  section is more rails out of the same supply and more time at the same pace
scoreboard players operation #gen_extra dr_var = #gen_route dr_var
scoreboard players operation #gen_extra dr_var -= $SectionWidth dr_const
execute if score #gen_extra dr_var matches ..-1 run scoreboard players set #gen_extra dr_var 0
scoreboard players operation #gen_extra dr_var *= #gen_rail_pen dr_var
scoreboard players add #gen_extra dr_var 100
scoreboard players operation #gen_rate dr_var = #gen_rate_raw dr_var
scoreboard players operation #gen_rate dr_var *= #gen_extra dr_var
scoreboard players operation #gen_rate dr_var /= $Hundred dr_const

execute if score #gen_reached dr_var matches 1 run function derailed:dev/gen/_rate_tally

# Counted for the report, as seeds rather than tiles, since a seed is a whole
#  patch
execute store result score #gen_wood dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=1},distance=0..]
execute store result score #gen_iron dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=2},distance=0..]

scoreboard players set #gen_valid dr_var 0
execute if score #gen_reached dr_var matches 1 if score #gen_rate dr_var >= #gen_rate_min dr_var if score #gen_rate dr_var <= #gen_rate_max dr_var run scoreboard players set #gen_valid dr_var 1

execute if score #gen_reached dr_var matches 0 run scoreboard players add #gen_fail_path dr_var 1
execute if score #gen_reached dr_var matches 1 if score #gen_rate dr_var < #gen_rate_min dr_var run scoreboard players add #gen_fail_cheap dr_var 1
execute if score #gen_reached dr_var matches 1 if score #gen_rate dr_var > #gen_rate_max dr_var run scoreboard players add #gen_fail_dear dr_var 1
