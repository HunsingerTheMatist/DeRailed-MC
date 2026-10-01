
# Puts this cut tile in run '#big_run', and every cut tile beside it in none yet
# Run as the tile's marker, at it

scoreboard players operation @s dr_brun = #big_run dr_temp
execute positioned ~3 ~ ~ as @e[type=marker,tag=dr_big_cut,scores={dr_brun=0},distance=..0.5] at @s run function derailed:dev/big/_cut_spread
execute positioned ~-3 ~ ~ as @e[type=marker,tag=dr_big_cut,scores={dr_brun=0},distance=..0.5] at @s run function derailed:dev/big/_cut_spread
execute positioned ~ ~ ~3 as @e[type=marker,tag=dr_big_cut,scores={dr_brun=0},distance=..0.5] at @s run function derailed:dev/big/_cut_spread
execute positioned ~ ~ ~-3 as @e[type=marker,tag=dr_big_cut,scores={dr_brun=0},distance=..0.5] at @s run function derailed:dev/big/_cut_spread
