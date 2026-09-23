
# Puts this tile on the wave its cost falls due, or, for the tile the track
#  leaves on, takes that wave as the cost of the route
# Positioned on the tile

scoreboard players set #cost_c dr_var 1
execute if block ~ ~ ~ #derailed:cost_resource run scoreboard players set #cost_c dr_var 2
execute if block ~ ~ ~ #derailed:cost_water run scoreboard players set #cost_c dr_var 4

scoreboard players operation #cost_w dr_var = #cost_wave dr_var
scoreboard players operation #cost_w dr_var += #cost_c dr_var

# The exit is not spread from, so it never goes on a wave
execute if block ~ ~2 ~ gold_block run return run function derailed:dev/gen/_cost_reach

scoreboard players operation #cost_w dr_var %= $Eight dr_const
execute store result storage derailed:gen c.w int 1 run scoreboard players get #cost_w dr_var
function derailed:dev/gen/_cost_summon with storage derailed:gen c
scoreboard players add #cost_pending dr_var 1
