
# Sets the rounds that open the second way up going, then opens it up a round a
#  tick where it was found
# Positioned at the section's corner

function derailed:dev/gen/_second_refind_end
scoreboard players set #q_step dr_var 45
execute if score #gen_reached dr_var matches 1 run scoreboard players set #q_relief_mode dr_var 1
execute if score #gen_reached dr_var matches 1 run scoreboard players set #q_relief_ret dr_var 45
execute if score #gen_reached dr_var matches 1 run scoreboard players set #q_step dr_var 40
return 0
