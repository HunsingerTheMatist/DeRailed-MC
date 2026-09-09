# End a dash. Run as the player
#
# Resetting the counter rather than leaving it at zero stops this running again
#  on every following tick

item replace entity @s saddle with air
scoreboard players reset @s dr_dash_burst
