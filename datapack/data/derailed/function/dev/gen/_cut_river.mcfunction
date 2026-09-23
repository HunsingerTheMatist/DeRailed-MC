
# Turns a cut that is water from end to end into river

scoreboard players set #cut_water dr_var 0
execute as @e[type=marker,tag=dr_cut,distance=0..] at @s if block ~ ~ ~ blue_concrete run scoreboard players add #cut_water dr_var 1
execute if score #cut_water dr_var = #cut_n dr_var as @e[type=marker,tag=dr_cut,distance=0..] at @s run function derailed:dev/gen/_cut_wet
