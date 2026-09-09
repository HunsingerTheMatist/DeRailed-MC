# Turn the sprint key into a dash. Run as the player, every tick
#
# Sprinting has no advancement trigger, so the state is read from a predicate
#  every tick

# The game applies its own movement_speed modifier when sprinting starts, so
#  removing it leaves sprinting with no lasting speed of its own. It is added
#  once on the edge rather than every tick, so one removal holds until the
#  player stops and starts again
execute store result score #sprinting dr_temp if predicate derailed:is_sprinting
execute if score #sprinting dr_temp matches 1 run \
    attribute @s minecraft:movement_speed modifier remove minecraft:sprinting

# Holding the key dashes again as soon as the cooldown expires
execute if score #sprinting dr_temp matches 1 \
    unless score @s dr_dash_cd matches 1.. \
    run function derailed:player/dash

execute if score @s dr_dash_cd matches 1.. run scoreboard players remove @s dr_dash_cd 1
execute if score @s dr_dash_cd matches 0 run scoreboard players reset @s dr_dash_cd

# The burst ends a few ticks in, well before the cooldown does
execute if score @s dr_dash_burst matches 1.. run scoreboard players remove @s dr_dash_burst 1
execute if score @s dr_dash_burst matches 0 run function derailed:player/_dash_end
