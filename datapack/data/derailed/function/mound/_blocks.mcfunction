
# Builds the tile's nine columns, each told where in the tile it stands in
#  '#mcx' and '#mcz', from 0 at the west and north to 2 at the east and south
# Positioned at the tile's northwestern block

scoreboard players set #mcz dr_temp 0
scoreboard players set #mcx dr_temp 0
function derailed:mound/_block
scoreboard players set #mcx dr_temp 1
execute positioned ~1 ~ ~ run function derailed:mound/_block
scoreboard players set #mcx dr_temp 2
execute positioned ~2 ~ ~ run function derailed:mound/_block

scoreboard players set #mcz dr_temp 1
scoreboard players set #mcx dr_temp 0
execute positioned ~ ~ ~1 run function derailed:mound/_block
scoreboard players set #mcx dr_temp 1
execute positioned ~1 ~ ~1 run function derailed:mound/_block
scoreboard players set #mcx dr_temp 2
execute positioned ~2 ~ ~1 run function derailed:mound/_block

scoreboard players set #mcz dr_temp 2
scoreboard players set #mcx dr_temp 0
execute positioned ~ ~ ~2 run function derailed:mound/_block
scoreboard players set #mcx dr_temp 1
execute positioned ~1 ~ ~2 run function derailed:mound/_block
scoreboard players set #mcx dr_temp 2
execute positioned ~2 ~ ~2 run function derailed:mound/_block
