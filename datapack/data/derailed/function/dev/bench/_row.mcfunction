
# Places one 32 wide row and steps south to the next

scoreboard players set #bench_x dr_var 32
function derailed:dev/bench/_cell
scoreboard players remove #bench_z dr_var 1
execute if score #bench_z dr_var matches 1.. positioned ~ ~ ~1 run function derailed:dev/bench/_row
