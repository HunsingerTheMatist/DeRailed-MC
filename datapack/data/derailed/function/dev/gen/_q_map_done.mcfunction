
# Says what the queue's survey map for seed '#qs_seed' took, then starts the map
#  for the next seed, or ends the survey, putting back the tier and the fresh
#  starts, once none are left

scoreboard players operation #qs_att dr_var = #gen_rerolls dr_var
scoreboard players add #qs_att dr_var 3
tellraw @a [{text:"[qs] seed ",color:"gray"},{score:{name:"#qs_seed",objective:"dr_var"}},"   attempts ",{score:{name:"#qs_att",objective:"dr_var"}},"   started afresh ",{score:{name:"#gen_fresh_total",objective:"dr_var"}},"   loosened ",{score:{name:"#gen_lenient_sections",objective:"dr_var"}},"   floods stopped ",{score:{name:"#gen_leaks",objective:"dr_var"}}]

scoreboard players add #qs_seed dr_var 1
scoreboard players remove #qs_left dr_var 1
execute if score #qs_left dr_var matches 1.. run return run function derailed:dev/gen/_q_map

scoreboard players set #q_survey dr_var 0
scoreboard players set #q_on dr_var 0
scoreboard players operation #gen_difficulty dr_var = #q_tier_was dr_var
scoreboard players operation #gen_fresh_max dr_var = #q_fresh_was dr_var
tellraw @a {text:"[qs] done",color:"gray"}
