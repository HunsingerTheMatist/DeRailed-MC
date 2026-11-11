
# Counts the columns as high as '#ch_h' into '#ch_sum' with those lower, and
#  leaves '#ch_h' at the height once more than '#ch_i' of them are counted,
#  the height '#ch_i' columns in from the lowest, or tries a block higher

execute as @e[type=marker,tag=dr_big_col,distance=0..] if score @s dr_bh = #ch_h dr_temp run scoreboard players add #ch_sum dr_temp 1
execute if score #ch_sum dr_temp > #ch_i dr_temp run return 0
scoreboard players add #ch_h dr_temp 1
execute if score #ch_h dr_temp matches ..40 run function derailed:dev/big/_chest_height
