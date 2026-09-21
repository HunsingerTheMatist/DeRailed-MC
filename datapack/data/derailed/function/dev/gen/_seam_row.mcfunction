
# Carries one row over the western boundary, then moves to the next row

scoreboard players set #seam_has dr_var 0
execute positioned ~-1 ~ ~ as @n[type=marker,tag=dr_edge,distance=0..0.4] run function derailed:dev/gen/_seam_take
execute if score #seam_has dr_var matches 1 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_seam_plant

scoreboard players remove #gen_row dr_var 1
execute if score #gen_row dr_var matches 1.. positioned ~ ~ ~1 run function derailed:dev/gen/_seam_row
