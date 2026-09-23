
# Schedules one 32 wide row and steps south to the next

scoreboard players set #wave_x dr_var 32
function derailed:dev/wave/_cell
scoreboard players remove #wave_z dr_var 1
execute if score #wave_z dr_var matches 1.. positioned ~ ~ ~1 run function derailed:dev/wave/_row
