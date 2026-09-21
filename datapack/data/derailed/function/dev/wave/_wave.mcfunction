
# Wakes every marker that has come due, ages the rest, then runs the next wave

execute as @e[type=marker,tag=dr_bench,scores={dr_wave=..0}] at @s run function derailed:dev/wave/_woken
scoreboard players remove @e[type=marker,tag=dr_bench] dr_wave 1

scoreboard players remove #wave_n dr_var 1
execute if score #wave_n dr_var matches 1.. run function derailed:dev/wave/_wave
