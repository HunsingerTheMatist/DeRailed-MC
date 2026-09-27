
# Steps every tile '#wr_k' steps from water onto the land beside it not yet
#  reached, then does the same for those, until '#gen_water_reach' steps are
#  taken or nothing is left to step from
# Positioned at the section's corner

scoreboard players operation #wr_next dr_var = #wr_k dr_var
scoreboard players add #wr_next dr_var 1
execute as @e[type=marker,tag=dr_wq,distance=0..] if score @s dr_step = #wr_k dr_var at @s run function derailed:dev/gen/_water_spread
scoreboard players add #wr_k dr_var 1
execute if score #wr_k dr_var < #gen_water_reach dr_var if entity @e[type=marker,tag=dr_wq,distance=0..] run function derailed:dev/gen/_water_wave
