
# Scatters one section worth of seeds, then starts the next pass

execute positioned 1000.0 0.0 0.0 run function derailed:dev/gen/scatter

scoreboard players remove #gen_pass dr_var 1
execute if score #gen_pass dr_var matches 1.. run function derailed:dev/gen/_pass
