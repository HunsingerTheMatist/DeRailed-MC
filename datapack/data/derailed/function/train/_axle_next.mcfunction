
# Moves this axle onto the next tile of the track, as far into it as it ran
#  past the end of its own
# Run as the axle's marker

scoreboard players operation @s dr_ad -= @s dr_alen
scoreboard players add @s dr_ai 1
function derailed:train/_axle_load
