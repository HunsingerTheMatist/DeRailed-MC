
# Counts this river tile into '#s_len' and goes on to the river tile it flows
#  into, for as many tiles as the map has
# Positioned at the river tile

scoreboard players add #s_len dr_temp 1
execute if score #s_len dr_temp matches 600.. run return 0
scoreboard players set #s_d dr_temp -1
execute as @n[type=marker,tag=dr_big_river,distance=..0.5] run scoreboard players operation #s_d dr_temp = @s dr_bdir
execute if score #s_d dr_temp matches 0 positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_river,distance=..0.5] run return run function derailed:dev/big/_south_count
execute if score #s_d dr_temp matches 1 positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_river,distance=..0.5] run return run function derailed:dev/big/_south_count
execute if score #s_d dr_temp matches 2 positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_river,distance=..0.5] run return run function derailed:dev/big/_south_count
execute if score #s_d dr_temp matches 3 positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_river,distance=..0.5] run function derailed:dev/big/_south_count
