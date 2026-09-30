
# Takes what the first river came to, and returns 1 where the second is still
#  to be looked at
# Positioned at the section's corner

scoreboard players operation #riv_first dr_var = #riv_got dr_var
scoreboard players set #riv_second dr_var 0

# The search leaves its markers standing whether it got anywhere or not
# Holding them leaves the corners the walk ran over there to be read, which the
#  water cannot be read back as: a corner and the tile it wets are not the same
#  place
execute if score #gen_riv_hold dr_var matches 1 run return 0
return 1
