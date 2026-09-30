
# Ends one step of the supply's repair, trying the changes toward iron and
#  making the best found, then starts another step on the tick after, or goes
#  on to the end of the supply check once the search is done
# Positioned at the section's corner

scoreboard players set #q_step dr_var 32
execute positioned ~ ~15 ~ if function derailed:dev/gen/_rep_step_iron run scoreboard players set #q_step dr_var 31
return 1
