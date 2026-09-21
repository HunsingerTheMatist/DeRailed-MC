
# Rolls a kind for a seed the track runs through
# Rock is left out of the draw entirely, which is what keeps the corridor open
#  without anything having to check it afterwards

execute store result score #gen_roll dr_var run random value 1..45

execute if score #gen_roll dr_var matches 1..20 run return run scoreboard players set #gen_kind dr_var 0
execute if score #gen_roll dr_var matches 21..30 run return run scoreboard players set #gen_kind dr_var 1
execute if score #gen_roll dr_var matches 31..40 run return run scoreboard players set #gen_kind dr_var 2
scoreboard players set #gen_kind dr_var 3
