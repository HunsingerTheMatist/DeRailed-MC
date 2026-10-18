# Sets '#floor_top' to how high the top of the floor block here is drawn, in
#  pixels: a slab's 8, the iron's smooth sandstone slab's 12, a whole block's
#  16 and the iron's tall top block's 20
# Run at the floor block

scoreboard players set #floor_top dr_temp 16
execute if block ~ ~ ~ #minecraft:slabs[type=bottom] run scoreboard players set #floor_top dr_temp 8
execute if block ~ ~ ~ smooth_sandstone_slab[type=bottom] run scoreboard players set #floor_top dr_temp 12
execute if block ~ ~ ~ basalt[axis=x] run scoreboard players set #floor_top dr_temp 20
