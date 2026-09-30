
# Sets the second route's search up, then goes on to the search where the first
#  route pinches anywhere, and straight to drawing it where it does not; with
#  no way across at all, back to the step '#q_sec_ret' names
# Positioned at the section's corner

execute positioned ~ ~15 ~ unless function derailed:dev/gen/_second_a run return run scoreboard players operation #q_step dr_var = #q_sec_ret dr_var
scoreboard players set #q_step dr_var 46
execute if score #sec_pinched dr_var matches 1 run scoreboard players set #q_step dr_var 44
return 1
