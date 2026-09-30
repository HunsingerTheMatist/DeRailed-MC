
# Measures the first route again where it cut through rock, then opens it up a
#  round a tick before it is judged
# Positioned at the section's corner

execute store result score #q_w dr_var run scoreboard players get #gen_carved dr_var
execute positioned ~ ~15 ~ run function derailed:dev/gen/_validate_carve
scoreboard players set #q_relief_mode dr_var 0
scoreboard players set #q_relief_ret dr_var 42
scoreboard players set #q_step dr_var 40
execute if score #q_w dr_var matches 1.. run return 1
return 0
