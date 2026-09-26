
# Walks back the way the flood came, painting the route it took and marking any
#  rock it ran through to be cut
# The tile the flood started on is the one with no direction on it

scoreboard players remove #gen_steps dr_var 1
execute if score #gen_steps dr_var matches ..0 run return fail

# Rock on the route is marked to be cut, run by run, and every other tile is
#  noted for what stands at the ends of the runs
execute if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_cut_mark
execute unless block ~ ~ ~ gray_concrete run function derailed:dev/gen/_cut_seen

# Water under the route is counted, since every tile of it is a bridge to build
execute if block ~ ~ ~ #derailed:cost_water run scoreboard players add #gen_wet dr_var 1

# The first route's tiles are numbered from the last one along, for the second
#  route to be found along
execute if score #cost_mode dr_var matches 0 if block ~ ~2 ~ white_stained_glass run scoreboard players set #gen_back dr_var 0
execute if score #cost_mode dr_var matches 0 if block ~ ~2 ~ white_stained_glass run function derailed:dev/gen/_rp_mark

execute if block ~ ~2 ~ white_stained_glass run scoreboard players add #gen_route dr_var 1
execute if block ~ ~2 ~ white_stained_glass run return run setblock ~ ~2 ~ red_stained_glass strict

scoreboard players set #gen_back dr_var 0
execute if block ~ ~2 ~ light_blue_stained_glass run scoreboard players set #gen_back dr_var 1
execute if block ~ ~2 ~ cyan_stained_glass run scoreboard players set #gen_back dr_var 2
execute if block ~ ~2 ~ blue_stained_glass run scoreboard players set #gen_back dr_var 3
execute if block ~ ~2 ~ purple_stained_glass run scoreboard players set #gen_back dr_var 4

# Anything else means the trace has wandered off the flood
execute if score #gen_back dr_var matches 0 run return fail
execute if score #cost_mode dr_var matches 0 run function derailed:dev/gen/_rp_mark

# The way it came is also the way the track runs through here, which is what
#  the pinching is measured along
function derailed:dev/gen/_pinch_pair

# The second route is counted for how many of its tiles are off the first,
#  which lies three above
execute if score #cost_mode dr_var matches 1 unless block ~ ~3 ~ #derailed:second_route run scoreboard players add #gen_astray dr_var 1

setblock ~ ~2 ~ red_stained_glass strict
scoreboard players add #gen_route dr_var 1

# The column and row go along with the step, for telling the edges
execute if score #gen_back dr_var matches 1 run scoreboard players remove #trace_x dr_var 1
execute if score #gen_back dr_var matches 1 run return run execute positioned ~-1 ~ ~ run function derailed:dev/gen/_trace
execute if score #gen_back dr_var matches 2 run scoreboard players add #trace_x dr_var 1
execute if score #gen_back dr_var matches 2 run return run execute positioned ~1 ~ ~ run function derailed:dev/gen/_trace
execute if score #gen_back dr_var matches 3 run scoreboard players remove #trace_z dr_var 1
execute if score #gen_back dr_var matches 3 run return run execute positioned ~ ~ ~-1 run function derailed:dev/gen/_trace
scoreboard players add #trace_z dr_var 1
execute positioned ~ ~ ~1 run function derailed:dev/gen/_trace
