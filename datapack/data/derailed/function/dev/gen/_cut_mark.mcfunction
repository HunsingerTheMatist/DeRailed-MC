
# Marks a rock tile on the route to be cut, as part of the run of rock it lies
#  in, numbered along the run from the exit end
# The tile the track comes in on is the end of the route, so a run still open
#  there ends against the section before, whose tile lies one to the west
# Positioned on the tile

execute if score #cut_open dr_var matches 0 run function derailed:dev/gen/_cut_run_start

scoreboard players add #cut_pos dr_var 1
scoreboard players add #cut_n dr_var 1
execute summon marker run function derailed:dev/gen/_cut_marked

execute if block ~ ~2 ~ white_stained_glass positioned ~-1 ~ ~ run function derailed:dev/gen/_cut_seen
