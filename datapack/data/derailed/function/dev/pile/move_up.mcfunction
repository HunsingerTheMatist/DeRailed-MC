# Lifts this placement 3 blocks, its displays and collision with it, leaving it
#  standing on nothing for 'dev/pile/fall' to drop
# Its displays are the placement displays in its column up to 20 blocks over it
# Run as a placement's interaction entity

execute unless entity @s[type=interaction,tag=dr_placement] run return run tellraw @a [{text:"[pile] run as a placement's interaction, tagged dr_placement",color:"gray"}]

# Its collision comes away where it stands, which a count of 0 does
scoreboard players operation #lift_count dr_temp = @s dr_count
scoreboard players set @s dr_count 0
execute at @s run function derailed:placement/_set_collision
scoreboard players operation @s dr_count = #lift_count dr_temp

execute at @s positioned ~-0.5 ~ ~-0.5 as @e[type=item_display,tag=dr_placement,dx=0,dy=20,dz=0] at @s run tp @s ~ ~3 ~
execute at @s run tp @s ~ ~3 ~
execute at @s run function derailed:placement/_set_collision
