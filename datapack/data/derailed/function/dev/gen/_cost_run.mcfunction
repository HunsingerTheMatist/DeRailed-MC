
# Floods out from this tile, cheapest tiles first, until a tile the track's
#  last rail may lie on is reached or there is nowhere left to go
# Positioned on the entry tile, with those tiles marked in gold two above
# Each tile costs something to step onto - ground 1, wood or iron 2, water 4 -
#  and a tile is taken on the wave its cost falls due, so the first wave to take
#  a tile is the cheapest way there and the wave the exit is taken on is what the
#  cheapest route across costs. Rock costs a thousand, which is done in levels:
#  the flood runs out everywhere it can get without rock, then steps onto the
#  rock it came up against and runs on from there, a thousand the level

scoreboard players set #gen_reached dr_var 0
scoreboard players set #gen_cost dr_var 0
scoreboard players set #cost_level dr_var 0
scoreboard players set #cost_base dr_var 0
scoreboard players set #cost_waiting dr_var 0
scoreboard players set #cost_next dr_var 0

# The tile the track comes in on is already stood on, whatever it is, so it
#  costs nothing
setblock ~ ~2 ~ white_stained_glass strict
summon marker ~ ~ ~ {Tags:["dr_flood","dr_f0"]}
scoreboard players set #cost_pending dr_var 1
scoreboard players set #cost_wave dr_var 0
function derailed:dev/gen/_cost_wave

# Whatever was still due or parked when the exit was reached is not needed
kill @e[type=marker,tag=dr_flood,distance=0..]
