
# Puts this tile on the wave its cost falls due for the second route: nothing
#  for a tile of the first route or beside it, one for any other, and rock
#  '#gen_second_rock', parked for the wave that many on, so that a cut is
#  taken only where the way round would stray further than that
# Rock within four steps along the grid of one of the first route's pinched
#  cells is never cut, so that the two routes' pinches stay apart: it is not
#  put on any wave, and the arrow laid over it keeps the flood from coming back
#  to it
# Positioned on the tile, with the band round the first route three above

execute if block ~ ~ ~ gray_concrete if block ~ ~3 ~ #derailed:second_zone run return 0

# The station's building is never stepped onto, nor cut
execute if block ~ ~-15 ~ obsidian run return 0

execute if block ~ ~ ~ gray_concrete run return run function derailed:dev/gen/_cost_park2

scoreboard players set #cost_c dr_var 1
execute if block ~ ~3 ~ #derailed:second_band run scoreboard players set #cost_c dr_var 0

scoreboard players operation #cost_w dr_var = #cost_wave dr_var
scoreboard players operation #cost_w dr_var += #cost_c dr_var

# The exit is not spread from, so it never goes on a wave
execute if block ~ ~2 ~ gold_block run return run function derailed:dev/gen/_cost_reach

scoreboard players operation #cost_w dr_var %= $Eight dr_const
execute store result storage derailed:gen c.w int 1 run scoreboard players get #cost_w dr_var
function derailed:dev/gen/_cost_summon with storage derailed:gen c
scoreboard players add #cost_pending dr_var 1
