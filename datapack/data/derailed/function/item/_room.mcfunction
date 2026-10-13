# Sets '#room' to how high a placement standing '#base_rel' up this block can
#  reach before the first block in its way above, in ten-thousandths of a
#  block, looking only as high as '#want_count' of #curr_item would reach: a
#  layer each for a resource, a block for the bucket and a pixel for a tool
# Run at the bottom middle of the block the placement stands in

scoreboard players set #room_want dr_temp 625
execute if score #curr_item dr_arg = $Bucket dr_const run scoreboard players set #room_want dr_temp 10000
execute if score #curr_item dr_arg <= $LastResource dr_const run scoreboard players operation #room_want dr_temp = $ScaledLayer dr_const
execute if score #curr_item dr_arg = $Wood dr_const run scoreboard players operation #room_want dr_temp = $WoodLayer dr_const
execute if score #curr_item dr_arg <= $LastResource dr_const run scoreboard players operation #room_want dr_temp *= #want_count dr_temp

# The blocks that height reaches into, rounded up
scoreboard players operation #room_cap dr_temp = #base_rel dr_temp
scoreboard players operation #room_cap dr_temp += #room_want dr_temp
scoreboard players add #room_cap dr_temp 9999
scoreboard players operation #room_cap dr_temp /= $TenThousand dr_const

scoreboard players set #room_cells dr_temp 0
function derailed:item/_room_up
scoreboard players operation #room dr_temp = #room_cells dr_temp
scoreboard players operation #room dr_temp *= $TenThousand dr_const
scoreboard players operation #room dr_temp -= #base_rel dr_temp
