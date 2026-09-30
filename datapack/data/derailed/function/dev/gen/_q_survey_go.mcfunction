
# Starts the queue's survey on '#qs_left' seeds from '#qs_seed' on

scoreboard players operation #q_tier_was dr_var = #gen_difficulty dr_var
scoreboard players operation #q_fresh_was dr_var = #gen_fresh_max dr_var
scoreboard players set #q_survey dr_var 1
function derailed:dev/gen/_q_map
