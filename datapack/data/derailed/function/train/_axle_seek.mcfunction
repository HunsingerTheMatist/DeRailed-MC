
# Walks this axle on from tile to tile of the path until the '#train_axle'
#  left to go falls inside the tile it is on, and sets it that far in
# Run as the axle's marker

execute if score #train_axle dr_temp < @s dr_alen run return run scoreboard players operation @s dr_ad = #train_axle dr_temp
scoreboard players operation #train_axle dr_temp -= @s dr_alen
scoreboard players add @s dr_ai 1
function derailed:train/_axle_load
function derailed:train/_axle_seek
