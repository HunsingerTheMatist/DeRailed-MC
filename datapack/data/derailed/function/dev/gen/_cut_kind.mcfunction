
# Reads what terrain this tile is into '#cut_k': 0 ground, 1 wood, 2 iron, 3
#  water, 5 river, and -1 for anything else, air off the map most of all
# Positioned on the tile

scoreboard players set #cut_k dr_var -1
execute if block ~ ~ ~ lime_concrete run scoreboard players set #cut_k dr_var 0
execute if block ~ ~ ~ brown_concrete run scoreboard players set #cut_k dr_var 1
execute if block ~ ~ ~ light_gray_concrete run scoreboard players set #cut_k dr_var 2
execute if block ~ ~ ~ blue_concrete run scoreboard players set #cut_k dr_var 3
execute if block ~ ~ ~ light_blue_concrete run scoreboard players set #cut_k dr_var 5
