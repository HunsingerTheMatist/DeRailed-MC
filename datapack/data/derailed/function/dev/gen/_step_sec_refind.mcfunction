
# Finds the second way again where it cut through rock, then opens it up a round
#  a tick where it was found
# Positioned at the section's corner

execute store result score #q_w dr_var run scoreboard players get #gen_carved dr_var
execute positioned ~ ~15 ~ run function derailed:dev/gen/_second_refind
scoreboard players set #q_step dr_var 45
execute if score #gen_reached dr_var matches 1 run scoreboard players set #q_relief_mode dr_var 1
execute if score #gen_reached dr_var matches 1 run scoreboard players set #q_relief_ret dr_var 45
execute if score #gen_reached dr_var matches 1 run scoreboard players set #q_step dr_var 40
execute if score #q_w dr_var matches 1.. run return 1
return 0
