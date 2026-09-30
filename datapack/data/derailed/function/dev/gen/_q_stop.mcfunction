
# Stops the queue once every section asked for is built, puts back the tier
#  and the fresh starts it changed, and prints the report

execute if score #q_survey dr_var matches 1 run return run function derailed:dev/gen/_q_map_done
scoreboard players set #q_on dr_var 0
scoreboard players operation #gen_difficulty dr_var = #q_tier_was dr_var
scoreboard players operation #gen_fresh_max dr_var = #q_fresh_was dr_var
function derailed:dev/gen/report
