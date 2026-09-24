
# Puts this tile on the wave its cost falls due, or, for the tile the track
#  leaves on, takes that wave as the cost of the route
# Rock is not stepped onto while any way round it is left: a tile of it costs a
#  thousand, so it is parked for the level after this one instead of put on a
#  wave
# Positioned on the tile

# The second route's flood prices tiles by how far they lie from the first
#  route rather than by what they are
execute if score #cost_mode dr_var matches 1 run return run function derailed:dev/gen/_cost_take2

# The supply check's flood prices tiles by the water on the way to them
execute if score #cost_mode dr_var matches 2 run return run function derailed:dev/gen/_cost_take3

execute if block ~ ~ ~ gray_concrete run return run function derailed:dev/gen/_cost_park

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
