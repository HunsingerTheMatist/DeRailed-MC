
# Schedules one tile as a pending marker and steps east to the next

summon marker ~ ~ ~ {Tags:["dr_bench"]}
scoreboard players remove #wave_x dr_var 1
execute if score #wave_x dr_var matches 1.. positioned ~1 ~ ~ run function derailed:dev/wave/_cell
