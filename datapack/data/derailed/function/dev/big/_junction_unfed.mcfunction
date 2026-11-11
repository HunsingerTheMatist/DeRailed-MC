
# Has the river tile beside this one feed it where nothing flows into it, so
#  a river setting out from another, as a second river running into the first
#  does, leaves it as a split: the tile behind it first, then the tile to
#  either side, never the one it flows into
# Run as the marker of a river tile nothing flows into, at it

execute if entity @s[tag=dr_big_n] positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_river,distance=..0.5] run return run function derailed:dev/big/_junction_join {way:"n"}
execute if entity @s[tag=dr_big_e] positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_river,distance=..0.5] run return run function derailed:dev/big/_junction_join {way:"e"}
execute if entity @s[tag=dr_big_s] positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_river,distance=..0.5] run return run function derailed:dev/big/_junction_join {way:"s"}
execute if entity @s[tag=dr_big_w] positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_river,distance=..0.5] run return run function derailed:dev/big/_junction_join {way:"w"}

execute unless entity @s[tag=dr_big_s] positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_river,distance=..0.5] run return run function derailed:dev/big/_junction_join {way:"n"}
execute unless entity @s[tag=dr_big_w] positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_river,distance=..0.5] run return run function derailed:dev/big/_junction_join {way:"e"}
execute unless entity @s[tag=dr_big_n] positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_river,distance=..0.5] run return run function derailed:dev/big/_junction_join {way:"s"}
execute unless entity @s[tag=dr_big_e] positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_river,distance=..0.5] run function derailed:dev/big/_junction_join {way:"w"}
