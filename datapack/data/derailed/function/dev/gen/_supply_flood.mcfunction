
# Runs the supply check's flood out from the first route: every tile of it is
#  stood on already, and the flood spreads until there is nowhere left to go,
#  never looking for an exit
# Positioned at the section's corner, with the route's tiles marked and a
#  marker on each

scoreboard players set #gen_reached dr_var 0
scoreboard players set #cost_level dr_var 0
scoreboard players set #cost_base dr_var 0
scoreboard players set #cost_waiting dr_var 0
scoreboard players set #cost_next dr_var 0
execute store result score #cost_pending dr_var if entity @e[type=marker,tag=dr_flood,distance=0..]
scoreboard players set #cost_wave dr_var 0
function derailed:dev/gen/_cost_wave

kill @e[type=marker,tag=dr_flood,distance=0..]
