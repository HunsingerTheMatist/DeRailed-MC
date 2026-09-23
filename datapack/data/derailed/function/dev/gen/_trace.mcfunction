
# Walks back the way the flood came, painting the route it took and marking any
#  rock it ran through to be cut
# The tile the flood started on is the one with no direction on it

scoreboard players remove #gen_steps dr_var 1
execute if score #gen_steps dr_var matches ..0 run return fail

# Rock on the route is marked to be cut, run by run, and every other tile is
#  noted for what stands at the ends of the runs
execute if block ~ ~ ~ gray_concrete run function derailed:dev/gen/_cut_mark
execute unless block ~ ~ ~ gray_concrete run function derailed:dev/gen/_cut_seen

execute if block ~ ~2 ~ white_stained_glass run scoreboard players add #gen_route dr_var 1
execute if block ~ ~2 ~ white_stained_glass run return run setblock ~ ~2 ~ red_stained_glass strict

scoreboard players set #gen_back dr_var 0
execute if block ~ ~2 ~ light_blue_stained_glass run scoreboard players set #gen_back dr_var 1
execute if block ~ ~2 ~ cyan_stained_glass run scoreboard players set #gen_back dr_var 2
execute if block ~ ~2 ~ blue_stained_glass run scoreboard players set #gen_back dr_var 3
execute if block ~ ~2 ~ purple_stained_glass run scoreboard players set #gen_back dr_var 4

# Anything else means the trace has wandered off the flood
execute if score #gen_back dr_var matches 0 run return fail

# The way it came is also the way the track runs through here, which is what
#  the pinching is measured along
function derailed:dev/gen/_pinch_pair

setblock ~ ~2 ~ red_stained_glass strict
scoreboard players add #gen_route dr_var 1

execute if score #gen_back dr_var matches 1 run return run execute positioned ~-1 ~ ~ run function derailed:dev/gen/_trace
execute if score #gen_back dr_var matches 2 run return run execute positioned ~1 ~ ~ run function derailed:dev/gen/_trace
execute if score #gen_back dr_var matches 3 run return run execute positioned ~ ~ ~-1 run function derailed:dev/gen/_trace
execute positioned ~ ~ ~1 run function derailed:dev/gen/_trace
