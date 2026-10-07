
# Places this tile's structure: one of the five grounds taken at random, the
#  lake, or the river flowing the way it was tagged, turning from the way it is
#  fed where it bends, the lake and the rivers two lower, since they reach two
#  further down
# Run as the tile's marker, at it

execute if entity @s[tag=dr_big_ground] run return run function derailed:dev/big/_ground
execute if entity @s[tag=dr_big_lake] run return run place template derailed:lake ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_e,tag=dr_big_n] run return run place template derailed:river/river_en ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_e,tag=dr_big_s] run return run place template derailed:river/river_es ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_n,tag=dr_big_e] run return run place template derailed:river/river_ne ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_n,tag=dr_big_w] run return run place template derailed:river/river_nw ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_s,tag=dr_big_e] run return run place template derailed:river/river_se ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_s,tag=dr_big_w] run return run place template derailed:river/river_sw ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_w,tag=dr_big_n] run return run place template derailed:river/river_wn ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_w,tag=dr_big_s] run return run place template derailed:river/river_ws ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_n] run return run place template derailed:river/river_n ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_e] run return run place template derailed:river/river_e ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_s] run return run place template derailed:river/river_s ~ ~-2 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_w] run place template derailed:river/river_w ~ ~-2 ~ none none 1 0 strict
