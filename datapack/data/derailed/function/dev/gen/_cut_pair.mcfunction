
# Fills in the tile at each end of what is left of run '#cut_r', then closes in

execute as @e[type=marker,tag=dr_cut,distance=0..] if score @s dr_step = #cut_r dr_var if score @s dr_wave = #cut_lo dr_var at @s run function derailed:dev/gen/_carve
execute if score #cut_hi dr_var > #cut_lo dr_var as @e[type=marker,tag=dr_cut,distance=0..] if score @s dr_step = #cut_r dr_var if score @s dr_wave = #cut_hi dr_var at @s run function derailed:dev/gen/_carve

scoreboard players add #cut_lo dr_var 1
scoreboard players remove #cut_hi dr_var 1
execute if score #cut_lo dr_var <= #cut_hi dr_var run function derailed:dev/gen/_cut_pair
