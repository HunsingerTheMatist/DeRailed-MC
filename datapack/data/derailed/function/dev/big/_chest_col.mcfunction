
# Makes this marker a rock column's, at its top block of bedrock
# Run as the new marker

tag @s add dr_big_col
execute store result score @s dr_bh run data get entity @s Pos[1]
scoreboard players operation @s dr_bd = #ch_d dr_temp
