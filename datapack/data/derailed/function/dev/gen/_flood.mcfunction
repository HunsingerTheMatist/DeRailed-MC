
# Spreads over this tile if it can be crossed, and on to its neighbours
# Rock and the ground outside the section stop it; water does not, since water
#  can be bridged
# The glass colour records which way the flood arrived, which is what lets the
#  route be walked back from the exit afterwards

# Tiles are approached from every side, so the tile having been seen already is
#  much the most common answer and is worth asking first
execute if block ~ ~2 ~ #derailed:flood_visited run return 0
execute if score #gen_reached dr_var matches 1 run return 0
execute if block ~ ~ ~ air run return 0
execute if block ~ ~ ~ gray_concrete run return 0

# The tile the track leaves on takes its direction like any other, since the
#  route is walked back from it
execute if block ~ ~2 ~ gold_block run scoreboard players set #gen_reached dr_var 1
function derailed:dev/gen/_mark
execute if score #gen_reached dr_var matches 1 run return 0

# East first, since that is where the exit is, then the way the exit lies
# A search that heads away from the exit first walks the whole of the wrong half
#  of the section before it turns round
execute if score #gen_south dr_var matches 1 run return run function derailed:dev/gen/_spread_s
function derailed:dev/gen/_spread_n
