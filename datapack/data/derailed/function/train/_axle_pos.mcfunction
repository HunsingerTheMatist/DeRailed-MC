
# Stands this axle where it is along its tile
# A straight tile runs from the middle of the edge it comes in by to the middle
#  of the far edge; a corner is a quarter turn round the tile's corner inside
#  the turn, from the middle of one edge to the middle of the other, 2356 long
# Ways are 0 north, 1 east, 2 south and 3 west
# Run as the axle's marker

# Each way as a step on x and on z, coming in and going out
scoreboard players set #dix dr_temp 0
scoreboard players set #diz dr_temp 0
execute if score @s dr_adin matches 0 run scoreboard players set #diz dr_temp -1
execute if score @s dr_adin matches 1 run scoreboard players set #dix dr_temp 1
execute if score @s dr_adin matches 2 run scoreboard players set #diz dr_temp 1
execute if score @s dr_adin matches 3 run scoreboard players set #dix dr_temp -1
scoreboard players set #dox dr_temp 0
scoreboard players set #doz dr_temp 0
execute if score @s dr_adout matches 0 run scoreboard players set #doz dr_temp -1
execute if score @s dr_adout matches 1 run scoreboard players set #dox dr_temp 1
execute if score @s dr_adout matches 2 run scoreboard players set #doz dr_temp 1
execute if score @s dr_adout matches 3 run scoreboard players set #dox dr_temp -1

execute if score @s dr_adin = @s dr_adout run return run function derailed:train/_axle_in
function derailed:train/_axle_turn
