
# Finds where the section's chests go among its rock columns and puts them
#  there, as '_chest' says

# The height 90% of the way through the columns' heights, lowest first
execute store result score #ch_n dr_temp if entity @e[type=marker,tag=dr_big_col,distance=0..]
execute if score #ch_n dr_temp matches 0 run return 0
scoreboard players operation #ch_i dr_temp = #ch_n dr_temp
scoreboard players remove #ch_i dr_temp 1
scoreboard players set #ch_t dr_temp 9
scoreboard players operation #ch_i dr_temp *= #ch_t dr_temp
scoreboard players set #ch_t dr_temp 10
scoreboard players operation #ch_i dr_temp /= #ch_t dr_temp
scoreboard players set #ch_h dr_temp 15
scoreboard players set #ch_sum dr_temp 0
function derailed:dev/big/_chest_height

execute if score $Difficulty dr_config matches ..0 if function derailed:dev/big/_chest_one run return 1
execute if score $Difficulty dr_config matches ..0 run return run tellraw @a "[chest] No spot in this section's rock fits a chest"
scoreboard players set #ch_rad dr_temp 30
execute if function derailed:dev/big/_chest_pair run return 1
scoreboard players set #ch_rad dr_temp 20
execute if function derailed:dev/big/_chest_pair run return 1
execute if function derailed:dev/big/_chest_one run return run tellraw @a "[chest] No two spots in this section's rock are 20 blocks apart on different regions, so it has one chest"
tellraw @a "[chest] No spot in this section's rock fits a chest"
