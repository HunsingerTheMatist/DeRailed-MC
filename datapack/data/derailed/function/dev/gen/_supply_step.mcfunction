
# One tile of the walk back to the route: counts the water here, then steps
#  the way the flood came
# Positioned on the tile, with the flood's marks two above and the bridges
#  three above

scoreboard players remove #gen_steps dr_var 1
execute if score #gen_steps dr_var matches ..0 run return fail
execute if block ~ ~2 ~ white_stained_glass run return 0

execute if block ~ ~ ~ #derailed:cost_water unless block ~ ~3 ~ cyan_stained_glass run scoreboard players add #sup_new dr_var 1
execute if score #sup_mark dr_var matches 1 if block ~ ~ ~ #derailed:cost_water run setblock ~ ~3 ~ cyan_stained_glass strict

execute if block ~ ~2 ~ light_blue_stained_glass run return run execute positioned ~-1 ~ ~ run function derailed:dev/gen/_supply_step
execute if block ~ ~2 ~ cyan_stained_glass run return run execute positioned ~1 ~ ~ run function derailed:dev/gen/_supply_step
execute if block ~ ~2 ~ blue_stained_glass run return run execute positioned ~ ~ ~-1 run function derailed:dev/gen/_supply_step
execute if block ~ ~2 ~ purple_stained_glass run return run execute positioned ~ ~ ~1 run function derailed:dev/gen/_supply_step
