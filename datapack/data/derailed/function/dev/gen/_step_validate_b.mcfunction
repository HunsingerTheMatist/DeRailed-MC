
# Judges the first route once it is opened up, then goes on to the early order
#  check
# Positioned at the section's corner

execute positioned ~ ~15 ~ run function derailed:dev/gen/_validate_b
scoreboard players set #q_step dr_var 11
return 0
