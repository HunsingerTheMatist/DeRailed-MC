
# Numbers every tile of the run beside this one and not yet numbered '#big_k1'
# Run as the tile's marker, at it

execute positioned ~3 ~ ~ run scoreboard players operation @e[type=marker,tag=dr_big_in,scores={dr_bord=0},distance=..0.5] dr_bord = #big_k1 dr_temp
execute positioned ~-3 ~ ~ run scoreboard players operation @e[type=marker,tag=dr_big_in,scores={dr_bord=0},distance=..0.5] dr_bord = #big_k1 dr_temp
execute positioned ~ ~ ~3 run scoreboard players operation @e[type=marker,tag=dr_big_in,scores={dr_bord=0},distance=..0.5] dr_bord = #big_k1 dr_temp
execute positioned ~ ~ ~-3 run scoreboard players operation @e[type=marker,tag=dr_big_in,scores={dr_bord=0},distance=..0.5] dr_bord = #big_k1 dr_temp
