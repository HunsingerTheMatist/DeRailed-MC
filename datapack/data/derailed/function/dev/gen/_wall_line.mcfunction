
# Runs the band a tile at a time from here to '#wall_tx' '#wall_tz', putting
#  the region under each tile on it
# Each step goes the way that has further to go, so the line runs as straight
#  to its end as tiles allow, and it never leaves the section since both its
#  ends are inside it
# Positioned on the tile, with '#wall_lx' and '#wall_lz' where that is

function derailed:dev/gen/_wall_take

scoreboard players operation #wall_dx dr_var = #wall_tx dr_var
scoreboard players operation #wall_dx dr_var -= #wall_lx dr_var
scoreboard players operation #wall_dz dr_var = #wall_tz dr_var
scoreboard players operation #wall_dz dr_var -= #wall_lz dr_var
execute if score #wall_dx dr_var matches 0 if score #wall_dz dr_var matches 0 run return 0

scoreboard players operation #wall_adx dr_var = #wall_dx dr_var
execute if score #wall_adx dr_var matches ..-1 run scoreboard players operation #wall_adx dr_var *= $NegOne dr_const
scoreboard players operation #wall_adz dr_var = #wall_dz dr_var
execute if score #wall_adz dr_var matches ..-1 run scoreboard players operation #wall_adz dr_var *= $NegOne dr_const

execute if score #wall_adx dr_var > #wall_adz dr_var if score #wall_dx dr_var matches 1.. run scoreboard players add #wall_lx dr_var 1
execute if score #wall_adx dr_var > #wall_adz dr_var if score #wall_dx dr_var matches 1.. run return run execute positioned ~1 ~ ~ run function derailed:dev/gen/_wall_line
execute if score #wall_adx dr_var > #wall_adz dr_var run scoreboard players remove #wall_lx dr_var 1
execute if score #wall_adx dr_var > #wall_adz dr_var run return run execute positioned ~-1 ~ ~ run function derailed:dev/gen/_wall_line
execute if score #wall_dz dr_var matches 1.. run scoreboard players add #wall_lz dr_var 1
execute if score #wall_dz dr_var matches 1.. run return run execute positioned ~ ~ ~1 run function derailed:dev/gen/_wall_line
scoreboard players remove #wall_lz dr_var 1
execute positioned ~ ~ ~-1 run function derailed:dev/gen/_wall_line
