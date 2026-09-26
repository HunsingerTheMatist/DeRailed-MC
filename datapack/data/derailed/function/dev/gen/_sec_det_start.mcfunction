
# Starts walking the detour back from the tile next to this one it stepped on
#  from, the way '#sec_via' names, which points back to this tile
# Run as the route tile's marker, positioned on it

scoreboard players set #sec_a dr_var 2
execute if score #sec_via dr_var matches 2 run scoreboard players set #sec_a dr_var 1
execute if score #sec_via dr_var matches 3 run scoreboard players set #sec_a dr_var 4
execute if score #sec_via dr_var matches 4 run scoreboard players set #sec_a dr_var 3
scoreboard players set #gen_steps dr_var 40
execute if score #sec_via dr_var matches 1 positioned ~-1 ~ ~ run return run function derailed:dev/gen/_sec_det_walk
execute if score #sec_via dr_var matches 2 positioned ~1 ~ ~ run return run function derailed:dev/gen/_sec_det_walk
execute if score #sec_via dr_var matches 3 positioned ~ ~ ~-1 run return run function derailed:dev/gen/_sec_det_walk
execute if score #sec_via dr_var matches 4 positioned ~ ~ ~1 run return run function derailed:dev/gen/_sec_det_walk
