
# Rolls a kind for an ordinary seed
# Weights are ground 20, rock 12, wood 10, iron 10, water 5 out of 57

execute store result score #gen_roll dr_var run random value 1..57

execute if score #gen_roll dr_var matches 1..20 run return run scoreboard players set #gen_kind dr_var 0
execute if score #gen_roll dr_var matches 21..32 run return run scoreboard players set #gen_kind dr_var 4
execute if score #gen_roll dr_var matches 33..42 run return run scoreboard players set #gen_kind dr_var 1
execute if score #gen_roll dr_var matches 43..52 run return run scoreboard players set #gen_kind dr_var 2
scoreboard players set #gen_kind dr_var 3
