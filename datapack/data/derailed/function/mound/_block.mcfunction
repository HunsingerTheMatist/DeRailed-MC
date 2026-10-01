
# Builds this column of the tile: its height the four corners weighed by how
#  near the column stands to each, out of thirty-six, a little either way on
#  its own and with the whole tile, a spike higher where it stands in the
#  tile's spiking corner, kept between '#msmin' and '#mmax' pixels, then made
#  of whole blocks with whatever of the kind's tops tops them nearest what is
#  left over
# Positioned at the column's foot

# Each corner's weight is one of 5, 3 and 1 from its side of the tile to the
#  far side, one way times the other
scoreboard players operation #mE dr_temp = #mcx dr_temp
scoreboard players operation #mE dr_temp *= #m2 dr_temp
scoreboard players add #mE dr_temp 1
scoreboard players set #mW dr_temp 6
scoreboard players operation #mW dr_temp -= #mE dr_temp
scoreboard players operation #mS dr_temp = #mcz dr_temp
scoreboard players operation #mS dr_temp *= #m2 dr_temp
scoreboard players add #mS dr_temp 1
scoreboard players set #mN dr_temp 6
scoreboard players operation #mN dr_temp -= #mS dr_temp

scoreboard players operation #mH dr_temp = #h00 dr_temp
scoreboard players operation #mH dr_temp *= #mW dr_temp
scoreboard players operation #mt dr_temp = #h10 dr_temp
scoreboard players operation #mt dr_temp *= #mE dr_temp
scoreboard players operation #mH dr_temp += #mt dr_temp
scoreboard players operation #mH dr_temp *= #mN dr_temp
scoreboard players operation #mt dr_temp = #h01 dr_temp
scoreboard players operation #mt dr_temp *= #mW dr_temp
scoreboard players operation #mu dr_temp = #h11 dr_temp
scoreboard players operation #mu dr_temp *= #mE dr_temp
scoreboard players operation #mt dr_temp += #mu dr_temp
scoreboard players operation #mt dr_temp *= #mS dr_temp
scoreboard players operation #mH dr_temp += #mt dr_temp
scoreboard players operation #mH dr_temp /= #m36 dr_temp

scoreboard players operation #mv dr_temp = #mjit dr_temp
function derailed:mound/_nudge
scoreboard players operation #mH dr_temp += #mj dr_temp
scoreboard players operation #mH dr_temp += #mtj dr_temp

# The spiking corner is the two by two columns at one of the tile's corners,
#  northwest, northeast, southwest or southeast
scoreboard players set #mhit dr_temp 0
execute if score #msq dr_temp matches 0 if score #mcx dr_temp matches ..1 if score #mcz dr_temp matches ..1 run scoreboard players set #mhit dr_temp 1
execute if score #msq dr_temp matches 1 if score #mcx dr_temp matches 1.. if score #mcz dr_temp matches ..1 run scoreboard players set #mhit dr_temp 1
execute if score #msq dr_temp matches 2 if score #mcx dr_temp matches ..1 if score #mcz dr_temp matches 1.. run scoreboard players set #mhit dr_temp 1
execute if score #msq dr_temp matches 3 if score #mcx dr_temp matches 1.. if score #mcz dr_temp matches 1.. run scoreboard players set #mhit dr_temp 1
execute if score #mhit dr_temp matches 1 run scoreboard players operation #mH dr_temp += #mspkpx dr_temp
execute if score #mH dr_temp < #msmin dr_temp run scoreboard players operation #mH dr_temp = #msmin dr_temp
execute if score #mH dr_temp > #mmax dr_temp run scoreboard players operation #mH dr_temp = #mmax dr_temp

# How many whole blocks, and what tops them: '#mtopi' the tall top block in
#  place of the top whole block and '#mcap' the slab over them, each -1 for
#  none
scoreboard players operation #mk dr_temp = #mH dr_temp
scoreboard players operation #mk dr_temp /= #m16 dr_temp
scoreboard players operation #mH dr_temp %= #m16 dr_temp
scoreboard players set #mtopi dr_temp -1
scoreboard players set #mcap dr_temp -1
execute if score #mound_kind dr_arg matches 0 run function derailed:mound/_quant_iron
execute if score #mound_kind dr_arg matches 1 run function derailed:mound/_quant_rock

execute if score #mound_kind dr_arg matches 0 run function derailed:mound/_column_iron
execute if score #mound_kind dr_arg matches 1 run function derailed:mound/_column_rock
