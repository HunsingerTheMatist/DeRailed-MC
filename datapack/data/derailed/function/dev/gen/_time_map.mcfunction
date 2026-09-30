
# Starts the map for seed '#ts_seed': the generator's random sequence from that
#  seed, and the test area cleared and set up as 'dev/gen/test' leaves it

execute store result storage derailed:gen prof.seed int 1 run scoreboard players get #ts_seed dr_var
function derailed:dev/gen/_reseed with storage derailed:gen prof
scoreboard players set #gen_init_ok dr_var 0
function derailed:dev/gen/init
execute unless score #gen_init_ok dr_var matches 1 run tellraw @a {text:"[gen] 'dev/gen/init' did not run to the end, so nothing was built; the log names the function that failed to load",color:"red"}
