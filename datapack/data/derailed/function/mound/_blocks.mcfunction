
# Builds the tile's nine columns: works out how high each stands first, into
#  '#mh0' to '#mh8' from west to east and north to south, each told where in
#  the tile it stands in '#mcx' and '#mcz', from 0 at the west and north to 2 at
#  the east and south, gives a tile that would come out flat a spiking corner,
#  and then builds them
# Positioned at the tile's northwestern block

scoreboard players set #mcz dr_temp 0
scoreboard players set #mcx dr_temp 0
function derailed:mound/_block
scoreboard players operation #mh0 dr_temp = #mH dr_temp
scoreboard players set #mcx dr_temp 1
function derailed:mound/_block
scoreboard players operation #mh1 dr_temp = #mH dr_temp
scoreboard players set #mcx dr_temp 2
function derailed:mound/_block
scoreboard players operation #mh2 dr_temp = #mH dr_temp

scoreboard players set #mcz dr_temp 1
scoreboard players set #mcx dr_temp 0
function derailed:mound/_block
scoreboard players operation #mh3 dr_temp = #mH dr_temp
scoreboard players set #mcx dr_temp 1
function derailed:mound/_block
scoreboard players operation #mh4 dr_temp = #mH dr_temp
scoreboard players set #mcx dr_temp 2
function derailed:mound/_block
scoreboard players operation #mh5 dr_temp = #mH dr_temp

scoreboard players set #mcz dr_temp 2
scoreboard players set #mcx dr_temp 0
function derailed:mound/_block
scoreboard players operation #mh6 dr_temp = #mH dr_temp
scoreboard players set #mcx dr_temp 1
function derailed:mound/_block
scoreboard players operation #mh7 dr_temp = #mH dr_temp
scoreboard players set #mcx dr_temp 2
function derailed:mound/_block
scoreboard players operation #mh8 dr_temp = #mH dr_temp

execute if score #msq dr_temp matches -1 run function derailed:mound/_unflat

scoreboard players operation #mH dr_temp = #mh0 dr_temp
function derailed:mound/_column
scoreboard players operation #mH dr_temp = #mh1 dr_temp
execute positioned ~1 ~ ~ run function derailed:mound/_column
scoreboard players operation #mH dr_temp = #mh2 dr_temp
execute positioned ~2 ~ ~ run function derailed:mound/_column
scoreboard players operation #mH dr_temp = #mh3 dr_temp
execute positioned ~ ~ ~1 run function derailed:mound/_column
scoreboard players operation #mH dr_temp = #mh4 dr_temp
execute positioned ~1 ~ ~1 run function derailed:mound/_column
scoreboard players operation #mH dr_temp = #mh5 dr_temp
execute positioned ~2 ~ ~1 run function derailed:mound/_column
scoreboard players operation #mH dr_temp = #mh6 dr_temp
execute positioned ~ ~ ~2 run function derailed:mound/_column
scoreboard players operation #mH dr_temp = #mh7 dr_temp
execute positioned ~1 ~ ~2 run function derailed:mound/_column
scoreboard players operation #mH dr_temp = #mh8 dr_temp
execute positioned ~2 ~ ~2 run function derailed:mound/_column
