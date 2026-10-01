
# Places one of the five grounds, taken at random
# Positioned at the tile's northwestern block, two below the ground

execute store result score #big_r dr_temp run random value 1..5 derailed:terrain
execute if score #big_r dr_temp matches 1 run return run place template derailed:ground/ground_1 ~ ~ ~ none none 1 0 strict
execute if score #big_r dr_temp matches 2 run return run place template derailed:ground/ground_2 ~ ~ ~ none none 1 0 strict
execute if score #big_r dr_temp matches 3 run return run place template derailed:ground/ground_3 ~ ~ ~ none none 1 0 strict
execute if score #big_r dr_temp matches 4 run return run place template derailed:ground/ground_4 ~ ~ ~ none none 1 0 strict
place template derailed:ground/ground_5 ~ ~ ~ none none 1 0 strict
