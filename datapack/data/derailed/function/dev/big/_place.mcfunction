
# Places this tile's structure: one of the five grounds taken at random, the
#  lake, or the river flowing the way it was tagged, the lake and the rivers two
#  lower, since they reach two further down
# Run as the tile's marker, at it

execute if entity @s[tag=dr_big_ground] run return run function derailed:dev/big/_ground
execute if entity @s[tag=dr_big_lake] run return run place template derailed:lake ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_n] run return run place template derailed:river/river_n ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_e] run return run place template derailed:river/river_e ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_s] run return run place template derailed:river/river_s ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_w] run place template derailed:river/river_w ~ ~-2 ~ none none 1 0 strict
