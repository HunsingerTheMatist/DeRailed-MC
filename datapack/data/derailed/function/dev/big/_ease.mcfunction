
# Eases this bend into the straight river on either side of it, where there is
#  one: a piece named for the bend and the way that river flows, laid on the
#  water across the edge between them, a block into the straight river
# Run as the bend's marker, at it

execute if entity @s[tag=dr_big_feed_e,tag=dr_big_n] positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_e,tag=!dr_big_bend,distance=..0.5] positioned ~3 ~ ~ run place template derailed:river/river_en_e ~-1 ~1 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_e,tag=dr_big_n] positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_n,tag=!dr_big_bend,distance=..0.5] positioned ~ ~ ~3 run place template derailed:river/river_en_n ~ ~1 ~-1 none none 1 0 strict
execute if entity @s[tag=dr_big_feed_e,tag=dr_big_s] positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_e,tag=!dr_big_bend,distance=..0.5] positioned ~3 ~ ~ run place template derailed:river/river_es_e ~-1 ~1 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_e,tag=dr_big_s] positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_s,tag=!dr_big_bend,distance=..0.5] positioned ~ ~ ~-3 run place template derailed:river/river_es_s ~ ~1 ~2 none none 1 0 strict

execute if entity @s[tag=dr_big_feed_n,tag=dr_big_e] positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_n,tag=!dr_big_bend,distance=..0.5] positioned ~ ~ ~-3 run place template derailed:river/river_ne_n ~ ~1 ~2 none none 1 0 strict
execute if entity @s[tag=dr_big_feed_n,tag=dr_big_e] positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_e,tag=!dr_big_bend,distance=..0.5] positioned ~-3 ~ ~ run place template derailed:river/river_ne_e ~2 ~1 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_n,tag=dr_big_w] positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_n,tag=!dr_big_bend,distance=..0.5] positioned ~ ~ ~-3 run place template derailed:river/river_nw_n ~ ~1 ~2 none none 1 0 strict
execute if entity @s[tag=dr_big_feed_n,tag=dr_big_w] positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_w,tag=!dr_big_bend,distance=..0.5] positioned ~3 ~ ~ run place template derailed:river/river_nw_w ~-1 ~1 ~ none none 1 0 strict

execute if entity @s[tag=dr_big_feed_s,tag=dr_big_e] positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_s,tag=!dr_big_bend,distance=..0.5] positioned ~ ~ ~3 run place template derailed:river/river_se_s ~ ~1 ~-1 none none 1 0 strict
execute if entity @s[tag=dr_big_feed_s,tag=dr_big_e] positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_e,tag=!dr_big_bend,distance=..0.5] positioned ~-3 ~ ~ run place template derailed:river/river_se_e ~2 ~1 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_s,tag=dr_big_w] positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_s,tag=!dr_big_bend,distance=..0.5] positioned ~ ~ ~3 run place template derailed:river/river_sw_s ~ ~1 ~-1 none none 1 0 strict
execute if entity @s[tag=dr_big_feed_s,tag=dr_big_w] positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_w,tag=!dr_big_bend,distance=..0.5] positioned ~3 ~ ~ run place template derailed:river/river_sw_w ~-1 ~1 ~ none none 1 0 strict

execute if entity @s[tag=dr_big_feed_w,tag=dr_big_n] positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_w,tag=!dr_big_bend,distance=..0.5] positioned ~-3 ~ ~ run place template derailed:river/river_wn_w ~2 ~1 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_w,tag=dr_big_n] positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_n,tag=!dr_big_bend,distance=..0.5] positioned ~ ~ ~3 run place template derailed:river/river_wn_n ~ ~1 ~-1 none none 1 0 strict
execute if entity @s[tag=dr_big_feed_w,tag=dr_big_s] positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_w,tag=!dr_big_bend,distance=..0.5] positioned ~-3 ~ ~ run place template derailed:river/river_ws_w ~2 ~1 ~ none none 1 0 strict
execute if entity @s[tag=dr_big_feed_w,tag=dr_big_s] positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_s,tag=!dr_big_bend,distance=..0.5] positioned ~ ~ ~-3 run place template derailed:river/river_ws_s ~ ~1 ~2 none none 1 0 strict
