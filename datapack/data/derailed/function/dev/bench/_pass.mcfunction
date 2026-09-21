
# Builds one section worth of markers and blocks, clears the markers, then
#  starts the next pass

scoreboard players set #bench_flip dr_var 1
execute if score #bench_parity dr_var matches 1 run scoreboard players set #bench_flip dr_var 0
scoreboard players operation #bench_parity dr_var = #bench_flip dr_var

scoreboard players set #bench_z dr_var 16
execute positioned 1000.0 0.0 0.0 run function derailed:dev/bench/_row
kill @e[type=marker,tag=dr_bench]
scoreboard players remove #bench_pass dr_var 1
execute if score #bench_pass dr_var matches 1.. run function derailed:dev/bench/_pass
