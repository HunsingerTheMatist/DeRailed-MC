
# Starts the queue's survey on the map for seed '#qs_seed': the generator's
#  random sequence from that seed, the test area set up as 'dev/gen/test' leaves
#  it, and the queue asked for three sections

execute store result storage derailed:gen prof.seed int 1 run scoreboard players get #qs_seed dr_var
function derailed:dev/gen/_reseed with storage derailed:gen prof
scoreboard players set #gen_init_ok dr_var 0
function derailed:dev/gen/init
execute unless score #gen_init_ok dr_var matches 1 run scoreboard players set #q_survey dr_var 0
execute unless score #gen_init_ok dr_var matches 1 run return run tellraw @a {text:"[gen] 'dev/gen/init' did not run to the end, so nothing was built; the log names the function that failed to load",color:"red"}

scoreboard players set #gen_fresh_max dr_var 2147483647
scoreboard players set #q_left dr_var 3
scoreboard players set #q_tier dr_var 0
scoreboard players set #q_step dr_var 0
scoreboard players set #q_on dr_var 1
