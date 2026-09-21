
# Places one benchmark cell and steps east to the next

summon marker ~ ~ ~ {Tags:["dr_bench"]}

# Alternating solid and air each pass makes every setblock a real opacity change,
#  so relighting is measured too
# Swapping between two opaque blocks skips the light check, and setting a block
#  to what it already is costs a lookup and nothing else
execute if score #bench_parity dr_var matches 0 run setblock ~ ~ ~ white_concrete strict
execute if score #bench_parity dr_var matches 1 run setblock ~ ~ ~ air strict

scoreboard players remove #bench_x dr_var 1
execute if score #bench_x dr_var matches 1.. positioned ~1 ~ ~ run function derailed:dev/bench/_cell
