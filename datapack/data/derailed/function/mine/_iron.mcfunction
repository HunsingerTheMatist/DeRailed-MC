
# Places stage '@s dr_mine_stage' of this iron, 2 or 3, on the ground, variants
#  1 to 5
# Run as the tile's mining marker, at it

execute if score @s dr_mine_stage matches 2 if score @s dr_mine_variant matches 1 run return run place template derailed:iron/iron_1_2 ~ ~2 ~ none none 1 0 strict
execute if score @s dr_mine_stage matches 2 if score @s dr_mine_variant matches 2 run return run place template derailed:iron/iron_2_2 ~ ~2 ~ none none 1 0 strict
execute if score @s dr_mine_stage matches 2 if score @s dr_mine_variant matches 3 run return run place template derailed:iron/iron_3_2 ~ ~2 ~ none none 1 0 strict
execute if score @s dr_mine_stage matches 2 if score @s dr_mine_variant matches 4 run return run place template derailed:iron/iron_4_2 ~ ~2 ~ none none 1 0 strict
execute if score @s dr_mine_stage matches 2 if score @s dr_mine_variant matches 5 run return run place template derailed:iron/iron_5_2 ~ ~2 ~ none none 1 0 strict
execute if score @s dr_mine_stage matches 3 if score @s dr_mine_variant matches 1 run return run place template derailed:iron/iron_1_3 ~ ~2 ~ none none 1 0 strict
execute if score @s dr_mine_stage matches 3 if score @s dr_mine_variant matches 2 run return run place template derailed:iron/iron_2_3 ~ ~2 ~ none none 1 0 strict
execute if score @s dr_mine_stage matches 3 if score @s dr_mine_variant matches 3 run return run place template derailed:iron/iron_3_3 ~ ~2 ~ none none 1 0 strict
execute if score @s dr_mine_stage matches 3 if score @s dr_mine_variant matches 4 run return run place template derailed:iron/iron_4_3 ~ ~2 ~ none none 1 0 strict
execute if score @s dr_mine_stage matches 3 if score @s dr_mine_variant matches 5 run return run place template derailed:iron/iron_5_3 ~ ~2 ~ none none 1 0 strict
