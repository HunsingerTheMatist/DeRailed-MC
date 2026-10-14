# Returns 1 when an entity stands where '#want_count' of #curr_item would
#  collide, on a placement standing '#hit_base' above here, in ten-thousandths
#  of a block, fail otherwise; a tool collides nowhere
# The test's box is the whole block across, and at least a block tall, reaching
#  down into the floor under a placement lower than that
# Run at the bottom middle of a block in the placement's column

execute if score #curr_item dr_arg >= $FirstTool dr_const if score #curr_item dr_arg <= $LastTool dr_const run return fail

# How high it collides: a pixel short of a pile's top, and a block for the
#  bucket
scoreboard players set #box_dy dr_temp 10000
execute if score #curr_item dr_arg <= $LastResource dr_const run scoreboard players operation #box_dy dr_temp = $ScaledLayer dr_const
execute if score #curr_item dr_arg = $Wood dr_const run scoreboard players operation #box_dy dr_temp = $WoodLayer dr_const
execute if score #curr_item dr_arg <= $LastResource dr_const run scoreboard players operation #box_dy dr_temp *= #want_count dr_temp
execute if score #curr_item dr_arg <= $LastResource dr_const run scoreboard players remove #box_dy dr_temp 625

# The box's bottom, and how far its top reaches past a block over that
scoreboard players remove #box_dy dr_temp 10000
scoreboard players operation #box_y dr_temp = #hit_base dr_temp
execute if score #box_dy dr_temp matches ..-1 run scoreboard players operation #box_y dr_temp += #box_dy dr_temp
execute if score #box_dy dr_temp matches ..-1 run scoreboard players set #box_dy dr_temp 0
execute store result storage derailed:macro box_y double 0.0001 run scoreboard players get #box_y dr_temp
execute store result storage derailed:macro box_dy double 0.0001 run scoreboard players get #box_dy dr_temp
return run function derailed:item/_entity_in_box with storage derailed:macro
