
# Finds the earliest wave any of the notes to the west was taken on

execute positioned ~-1 ~ ~ as @n[type=marker,tag=dr_edge,distance=0..0.4] run function derailed:dev/gen/_seam_min

scoreboard players remove #gen_row dr_var 1
execute if score #gen_row dr_var matches 1.. positioned ~ ~ ~1 run function derailed:dev/gen/_seam_scan
