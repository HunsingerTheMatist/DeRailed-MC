
# Places one of the ten trees, five oak and five spruce, taken at random
# Positioned at the tile's northwestern block, two below the ground

execute store result score #big_r dr_temp run random value 1..10 derailed:terrain
execute if score #big_r dr_temp matches 1 run return run place template derailed:tree/oak_1 ~ ~ ~ none none 1 0 strict
execute if score #big_r dr_temp matches 2 run return run place template derailed:tree/oak_2 ~ ~ ~ none none 1 0 strict
execute if score #big_r dr_temp matches 3 run return run place template derailed:tree/oak_3 ~ ~ ~ none none 1 0 strict
execute if score #big_r dr_temp matches 4 run return run place template derailed:tree/oak_4 ~ ~ ~ none none 1 0 strict
execute if score #big_r dr_temp matches 5 run return run place template derailed:tree/oak_5 ~ ~ ~ none none 1 0 strict
execute if score #big_r dr_temp matches 6 run return run place template derailed:tree/spruce_1 ~ ~ ~ none none 1 0 strict
execute if score #big_r dr_temp matches 7 run return run place template derailed:tree/spruce_2 ~ ~ ~ none none 1 0 strict
execute if score #big_r dr_temp matches 8 run return run place template derailed:tree/spruce_3 ~ ~ ~ none none 1 0 strict
execute if score #big_r dr_temp matches 9 run return run place template derailed:tree/spruce_4 ~ ~ ~ none none 1 0 strict
place template derailed:tree/spruce_5 ~ ~ ~ none none 1 0 strict
