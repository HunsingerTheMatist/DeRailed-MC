
# Decides whether the second way across is looked for, and sends the section on
#  to its search, or past it
# Positioned at the section's corner

# The second way across is found on every attempt the track can cross that the
#  first route's checks passed, and on the section's last attempt whatever they
#  said, since that one ships as it is; a section without one is a reroll like
#  a cheap one while '#gen_second_reroll' says so
# An attempt the first route's checks turned away is rerolled whatever the
#  second way would do, so it is not looked for
scoreboard players set #sec_reached dr_var 0
scoreboard players set #sec_ran dr_var 0
execute if score #gen_valid dr_var matches 1 run scoreboard players set #sec_ran dr_var 1
execute if score #gen_attempts dr_var matches ..1 if score #gen_fresh_left dr_var matches ..0 run scoreboard players set #sec_ran dr_var 1
execute if score #gen_reached dr_var matches 0 run scoreboard players set #sec_ran dr_var 0

scoreboard players set #q_step dr_var 47
execute unless score #sec_ran dr_var matches 1 run return 0
scoreboard players set #q_sec_ret dr_var 47
scoreboard players set #q_step dr_var 43
return 0
