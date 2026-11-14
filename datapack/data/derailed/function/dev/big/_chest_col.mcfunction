
# Makes this marker a rock column's, at its top block of bedrock, holding its
#  height in 'dr_bh', its tile's depth in 'dr_bd' and region in 'dr_breg', and
#  where it stands across the ground in 'dr_bpx' and 'dr_bpz'
# Run as the new marker

tag @s add dr_big_col
execute store result score @s dr_bh run data get entity @s Pos[1]
execute store result score @s dr_bpx run data get entity @s Pos[0]
execute store result score @s dr_bpz run data get entity @s Pos[2]
scoreboard players operation @s dr_bd = #ch_d dr_temp
scoreboard players operation @s dr_breg = #ch_g dr_temp
