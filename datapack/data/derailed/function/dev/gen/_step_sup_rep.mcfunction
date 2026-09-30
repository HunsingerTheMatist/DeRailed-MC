
# Starts one step of the supply's repair, trying the changes toward wood, and
#  goes on to those toward iron on the tick after, or on to the end of the
#  supply check once the search is done
# Positioned at the section's corner

scoreboard players set #q_step dr_var 36
execute positioned ~ ~15 ~ unless function derailed:dev/gen/_rep_step_wood run scoreboard players set #q_step dr_var 32
return 1
