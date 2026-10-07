
# Tags this river tile's marker with the way the river feeding it flows, where
#  that is not the way this tile flows, 'dr_big_feed_n', 'dr_big_feed_e',
#  'dr_big_feed_s' or 'dr_big_feed_w'; a tile fed by a river flowing its own
#  way, or by none, is straight
# Run as the tile's marker, at it

execute if entity @s[tag=dr_big_n] positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_n,distance=..0.5] run return 0
execute if entity @s[tag=dr_big_e] positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_e,distance=..0.5] run return 0
execute if entity @s[tag=dr_big_s] positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_s,distance=..0.5] run return 0
execute if entity @s[tag=dr_big_w] positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_w,distance=..0.5] run return 0

execute unless entity @s[tag=dr_big_s] positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_n,distance=..0.5] run return run tag @s add dr_big_feed_n
execute unless entity @s[tag=dr_big_w] positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_e,distance=..0.5] run return run tag @s add dr_big_feed_e
execute unless entity @s[tag=dr_big_n] positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_s,distance=..0.5] run return run tag @s add dr_big_feed_s
execute unless entity @s[tag=dr_big_e] positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_w,distance=..0.5] run return run tag @s add dr_big_feed_w
