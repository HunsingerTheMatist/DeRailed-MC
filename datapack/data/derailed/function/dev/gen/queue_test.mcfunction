
# Builds what 'dev/gen/test' builds from seed '#q_seed', three joined sections,
#  easy, medium then hard, through the section queue a step a tick, and prints
#  the report once they are done
# No section is ever given up on: fresh starts go on for as long as it takes
# '#q_log' at 1 says in chat which step each tick runs
# Positions itself, so it is safe to call from anywhere

execute store result storage derailed:gen prof.seed int 1 run scoreboard players get #q_seed dr_var
function derailed:dev/gen/_reseed with storage derailed:gen prof
scoreboard players set #gen_init_ok dr_var 0
function derailed:dev/gen/init
execute unless score #gen_init_ok dr_var matches 1 run return run tellraw @a {text:"[gen] 'dev/gen/init' did not run to the end, so nothing was built; the log names the function that failed to load",color:"red"}

scoreboard players set #q_survey dr_var 0
scoreboard players operation #q_tier_was dr_var = #gen_difficulty dr_var
scoreboard players operation #q_fresh_was dr_var = #gen_fresh_max dr_var
scoreboard players set #gen_fresh_max dr_var 2147483647
scoreboard players set #q_left dr_var 3
scoreboard players set #q_tier dr_var 0
scoreboard players set #q_step dr_var 0
scoreboard players set #q_on dr_var 1
