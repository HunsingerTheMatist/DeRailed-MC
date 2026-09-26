
# Tries the four tiles next to this one, each told in '#sec_back' the way this
#  tile lies from it: 1 west, 2 east, 3 north, 4 south
# Positioned on the tile, with '#sec_d' the tiles run and '#sec_r' the rock
#  cut to reach it

scoreboard players set #sec_back dr_var 2
execute positioned ~-1 ~ ~ run function derailed:dev/gen/_sec_visit
scoreboard players set #sec_back dr_var 1
execute positioned ~1 ~ ~ run function derailed:dev/gen/_sec_visit
scoreboard players set #sec_back dr_var 4
execute positioned ~ ~ ~-1 run function derailed:dev/gen/_sec_visit
scoreboard players set #sec_back dr_var 3
execute positioned ~ ~ ~1 run function derailed:dev/gen/_sec_visit
