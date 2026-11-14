# Gives off the gold mote $(r) blocks out the way this marker faces and $(h)
#  up, gliding to $(x) $(y) $(z) over 40 ticks
# Run as the chest's 'dr_chest_spark' marker, at it

$execute rotated as @s positioned ^ ^ ^$(r) positioned ~ ~$(h) ~ run particle trail{target:[$(x),$(y),$(z)],color:16762675,duration:40} ~ ~ ~ 0 0 0 0 1
