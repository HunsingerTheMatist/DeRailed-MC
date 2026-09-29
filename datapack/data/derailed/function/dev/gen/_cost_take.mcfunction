
# Puts this tile on the wave its cost falls due, or, for a tile the track's
#  last rail may lie on, takes that wave as the cost of the route
# Rock is not stepped onto while any way round it is left: a tile of it costs a
#  thousand, so it is parked for the level after this one instead of put on a
#  wave
# Positioned on the tile

# The supply check's flood prices tiles by the water on the way to them
execute if score #cost_mode dr_var matches 2 run return run function derailed:dev/gen/_cost_take3

# The station's building is never stepped onto, nor cut
execute if block ~ ~-15 ~ obsidian run return 0

execute if block ~ ~ ~ gray_concrete run return run function derailed:dev/gen/_cost_park

# 'derailed:gen/cost_due' is the wave it falls due on: this one, and one for
#  ground, two for wood or iron and four for water
execute store result score #cost_w dr_var run compute block ~ ~ ~ integer derailed:gen/cost_due

# The last tile is not spread from, so it never goes on a wave
execute if block ~ ~2 ~ gold_block run return run function derailed:dev/gen/_cost_reach

execute store result storage derailed:gen c.w int 1 run scoreboard players operation #cost_w dr_var %= $Eight dr_const
function derailed:dev/gen/_cost_summon with storage derailed:gen c
scoreboard players add #cost_pending dr_var 1
