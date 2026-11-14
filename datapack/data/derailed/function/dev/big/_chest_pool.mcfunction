
# Puts in the pool, tagged 'dr_big_pool', every column within '#ch_w' blocks of
#  '#ch_h' high, none of them tried yet

tag @e[type=marker,tag=dr_big_pool,distance=0..] remove dr_big_pool
tag @e[type=marker,tag=dr_big_tried,distance=0..] remove dr_big_tried
scoreboard players operation #ch_lo dr_temp = #ch_h dr_temp
scoreboard players operation #ch_lo dr_temp -= #ch_w dr_temp
scoreboard players operation #ch_hi dr_temp = #ch_h dr_temp
scoreboard players operation #ch_hi dr_temp += #ch_w dr_temp
execute as @e[type=marker,tag=dr_big_col,distance=0..] if score @s dr_bh >= #ch_lo dr_temp if score @s dr_bh <= #ch_hi dr_temp run tag @s add dr_big_pool
