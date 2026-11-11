
# Tags this column 'dr_big_cand' where each of the four blocks beside its top
#  block is bedrock, or a rock slab where '#ch_slab' is set
# Run as the column's marker, at its top block

scoreboard players set #ch_f dr_temp 0
execute if block ~1 ~ ~ bedrock run scoreboard players add #ch_f dr_temp 1
execute if block ~-1 ~ ~ bedrock run scoreboard players add #ch_f dr_temp 1
execute if block ~ ~ ~1 bedrock run scoreboard players add #ch_f dr_temp 1
execute if block ~ ~ ~-1 bedrock run scoreboard players add #ch_f dr_temp 1
execute if score #ch_slab dr_temp matches 1 if block ~1 ~ ~ cobbled_deepslate_slab run scoreboard players add #ch_f dr_temp 1
execute if score #ch_slab dr_temp matches 1 if block ~-1 ~ ~ cobbled_deepslate_slab run scoreboard players add #ch_f dr_temp 1
execute if score #ch_slab dr_temp matches 1 if block ~ ~ ~1 cobbled_deepslate_slab run scoreboard players add #ch_f dr_temp 1
execute if score #ch_slab dr_temp matches 1 if block ~ ~ ~-1 cobbled_deepslate_slab run scoreboard players add #ch_f dr_temp 1
execute if score #ch_f dr_temp matches 4 run tag @s add dr_big_cand
