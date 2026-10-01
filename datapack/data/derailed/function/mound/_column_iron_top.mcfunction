
# Builds an iron column's top block, and the slab over it where it has one
# Positioned at the top block

execute if score #mtopi dr_temp matches 0 run setblock ~ ~ ~ basalt[axis=x] strict
execute unless score #mtopi dr_temp matches 0 run setblock ~ ~ ~ basalt[axis=y] strict
execute if score #mcap dr_temp matches 0 run setblock ~ ~1 ~ sandstone_slab[type=bottom] strict
execute if score #mcap dr_temp matches 1 run setblock ~ ~1 ~ smooth_sandstone_slab[type=bottom] strict
