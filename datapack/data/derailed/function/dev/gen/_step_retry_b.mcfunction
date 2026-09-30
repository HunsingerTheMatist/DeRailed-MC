
# Judges the first route again once its ends are opened, then looks for the
#  second way once more, coming back to count it after
# Positioned at the section's corner

execute positioned ~ ~15 ~ run function derailed:dev/gen/_second_retry_b
scoreboard players set #q_sec_ret dr_var 49
scoreboard players set #q_step dr_var 43
return 0
