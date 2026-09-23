
# Floods out from this tile, cheapest tiles first, until the tile the track
#  leaves on is reached or there is nowhere left to go
# Positioned on the entry tile, with the exit tile marked in gold two above
# Each tile costs something to step onto - ground 1, wood or iron 2, water 4 -
#  and a tile is taken on the wave its cost falls due, so the first wave to take
#  a tile is the cheapest way there and the wave the exit is taken on is what the
#  cheapest route across costs. Rock is never stepped onto

scoreboard players set #gen_reached dr_var 0
scoreboard players set #gen_cost dr_var 0

# The tile the track comes in on is already stood on, so it costs nothing
execute if block ~ ~ ~ gray_concrete run return fail
setblock ~ ~2 ~ white_stained_glass strict
summon marker ~ ~ ~ {Tags:["dr_flood","dr_f0"]}
scoreboard players set #cost_pending dr_var 1
scoreboard players set #cost_wave dr_var 0
function derailed:dev/gen/_cost_wave

# Whatever was still due when the exit was reached is not needed
kill @e[type=marker,tag=dr_flood,distance=0..]
