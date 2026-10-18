# Drops this placement from where it stands, as mining the floor out from under
#  it would
# Run as a placement's interaction entity

execute unless entity @s[type=interaction,tag=dr_placement] run return run tellraw @a [{text:"[pile] run as a placement's interaction, tagged dr_placement",color:"gray"}]

execute at @s run function derailed:placement/drop
