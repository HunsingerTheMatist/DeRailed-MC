# Applies one tile through the 'persist' mapping and steps east to the next

summon marker ~ ~ ~ {Tags:["dr_bench"]}
execute store result score @n[type=marker,tag=dr_bench,distance=0..0.5] dr_wave run random value 0..149
scoreboard players remove #idmap_x dr_var 1
execute if score #idmap_x dr_var matches 1.. positioned ~1 ~ ~ run function derailed:dev/idmap/persist/_cell
