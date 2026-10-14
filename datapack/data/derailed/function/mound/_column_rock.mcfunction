
# Builds the '#mk' whole blocks of a rock column still to go from here up, and
#  the slab over the top one as '#mcap' says
# Positioned at the next block of the column

execute if score #mk dr_temp matches ..1 run return run function derailed:mound/_column_rock_top
setblock ~ ~ ~ bedrock strict
scoreboard players remove #mk dr_temp 1
execute positioned ~ ~1 ~ run function derailed:mound/_column_rock
