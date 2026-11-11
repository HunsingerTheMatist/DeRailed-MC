
# Hides an ender chest in the section's rock, on the top block of one of its
#  columns: every rock column is measured to its top block of bedrock, slabs
#  left out, and the chest goes on one within two blocks of the height 90% of
#  the way up from the lowest to the highest, with bedrock on all four sides of
#  it, picked at random with the columns of a tile weighed by how deep in the
#  rock it is; where none is, the heights widen a block at a time and a rock
#  slab beside it will do too, made bedrock once the chest goes in
# Takes its random numbers from 'derailed:terrain', after everything else
# Run in the game's dimension

scoreboard players set @e[type=marker,tag=dr_big_rock,distance=0..] dr_bd 0
scoreboard players set #ch_k dr_temp 1
function derailed:dev/big/_chest_depth
execute as @e[type=marker,tag=dr_big_rock,distance=0..] at @s run function derailed:dev/big/_chest_cols

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

scoreboard players set #ch_w dr_temp 2
scoreboard players set #ch_slab dr_temp 0
function derailed:dev/big/_chest_band

# One of them at random, each as likely as its tile is deep, taken in order of
#  how near they stand to a point no two of them can be equally near
scoreboard players set #ch_t dr_temp 0
execute as @e[type=marker,tag=dr_big_cand,distance=0..] run scoreboard players operation #ch_t dr_temp += @s dr_bd
execute if score #ch_t dr_temp matches 1.. store result score #ch_r dr_temp run random value 0..2147483646 derailed:terrain
execute if score #ch_t dr_temp matches 1.. run scoreboard players operation #ch_r dr_temp %= #ch_t dr_temp
execute if score #ch_t dr_temp matches 1.. positioned 1099.37 0.0 -0.71 as @e[type=marker,tag=dr_big_cand,distance=0..,sort=nearest] run function derailed:dev/big/_chest_walk
execute as @e[type=marker,tag=dr_big_chest_at,distance=0..] at @s run function derailed:dev/big/_chest_place

kill @e[type=marker,tag=dr_big_col,distance=0..]
