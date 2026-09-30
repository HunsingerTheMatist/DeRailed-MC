
# Finds the first route and measures its pinching, then measures it again over
#  what it cut on the tick after
# Positioned at the section's corner

execute positioned ~ ~15 ~ run function derailed:dev/gen/_validate_a
scoreboard players set #q_step dr_var 53
return 1
