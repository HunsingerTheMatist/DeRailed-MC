
# Builds the '#mk' whole blocks of an iron column still to go from here up, the
#  top one and the slab over it as '#mtopi' and '#mcap' say
# Positioned at the next block of the column

execute if score #mk dr_temp matches ..1 run return run function derailed:mound/_column_iron_top
setblock ~ ~ ~ basalt[axis=y] strict
scoreboard players remove #mk dr_temp 1
execute positioned ~ ~1 ~ run function derailed:mound/_column_iron
