
# Counts this tile onto '#gen_route' and steps back the way the flood came, as
#  far as the tile it started on
# Positioned on the tile, with the flood's arrows two above

scoreboard players remove #true_steps dr_var 1
execute if score #true_steps dr_var matches ..0 run return fail
scoreboard players add #gen_route dr_var 1
execute if block ~ ~2 ~ white_stained_glass run return 0
execute if block ~ ~2 ~ light_blue_stained_glass positioned ~-1 ~ ~ run return run function derailed:dev/gen/_cheapest_walk
execute if block ~ ~2 ~ cyan_stained_glass positioned ~1 ~ ~ run return run function derailed:dev/gen/_cheapest_walk
execute if block ~ ~2 ~ blue_stained_glass positioned ~ ~ ~-1 run return run function derailed:dev/gen/_cheapest_walk
execute if block ~ ~2 ~ purple_stained_glass positioned ~ ~ ~1 run return run function derailed:dev/gen/_cheapest_walk
