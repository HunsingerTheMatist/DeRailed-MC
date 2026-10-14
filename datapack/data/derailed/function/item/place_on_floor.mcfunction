# Starts a placement standing on the top of the floor block here as it is
#  drawn, with as many of the items as there is room for over it
# Run as the player, at the bottom middle of the floor block
#
# Returns 1 when any items were placed, fail otherwise

execute if score #only_same_item dr_arg matches 1 run return fail

# How high the floor's top is drawn, in pixels: a slab's 8, the iron's smooth
#  sandstone slab's 12, a whole block's 16 and the iron's tall top block's 20
scoreboard players set #floor_top dr_temp 16
execute if block ~ ~ ~ #minecraft:slabs[type=bottom] run scoreboard players set #floor_top dr_temp 8
execute if block ~ ~ ~ smooth_sandstone_slab[type=bottom] run scoreboard players set #floor_top dr_temp 12
execute if block ~ ~ ~ basalt[axis=x] run scoreboard players set #floor_top dr_temp 20

# Where it stands in the block it stands in, in ten-thousandths of a block
scoreboard players operation #base_rel dr_temp = #floor_top dr_temp
scoreboard players operation #base_rel dr_temp *= $Pixel dr_const
scoreboard players operation #want_count dr_temp = #curr_item_count dr_arg
execute if score #floor_top dr_temp matches ..15 run function derailed:item/_room
execute if score #floor_top dr_temp matches 16.. run scoreboard players remove #base_rel dr_temp 10000
execute if score #floor_top dr_temp matches 16.. positioned ~ ~1 ~ run function derailed:item/_room

# Resources take as many as fit, the bucket needs a block and a tool a pixel
execute if score #curr_item dr_arg <= $LastResource dr_const run function derailed:item/_fit
execute if score #curr_item dr_arg <= $LastResource dr_const if score #fit dr_temp matches ..0 run return fail
execute if score #curr_item dr_arg = $Bucket dr_const if score #room dr_temp matches ..9999 run return fail
execute if score #room dr_temp matches ..624 run return fail

# As many as fit where nothing stands in the way
scoreboard players operation #want_count dr_temp = #curr_item_count dr_arg
execute if score #curr_item dr_arg <= $LastResource dr_const run scoreboard players operation #want_count dr_temp < #fit dr_temp
scoreboard players set #want_min dr_temp 1
scoreboard players operation #hit_base dr_temp = #floor_top dr_temp
scoreboard players operation #hit_base dr_temp *= $Pixel dr_const
execute unless function derailed:item/_fit_entities run return fail
scoreboard players operation #curr_item_count dr_arg = #want_count dr_temp

execute if score #floor_top dr_temp matches 8 positioned ~ ~0.5 ~ run return run function derailed:item/place_new
execute if score #floor_top dr_temp matches 12 positioned ~ ~0.75 ~ run return run function derailed:item/place_new
execute if score #floor_top dr_temp matches 16 positioned ~ ~1 ~ run return run function derailed:item/place_new
execute if score #floor_top dr_temp matches 20 positioned ~ ~1.25 ~ run return run function derailed:item/place_new
