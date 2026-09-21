
# Takes the walk on to the corner it settled on
# Positioned on the corner it is leaving

execute if score #riv_dir dr_var matches 0 positioned ~ ~ ~1 as @n[type=marker,tag=dr_riv_line,distance=..0.4] run return run function derailed:dev/gen/_river_short
execute if score #riv_dir dr_var matches 1 positioned ~-1 ~ ~ as @n[type=marker,tag=dr_riv_line,distance=..0.4] run return run function derailed:dev/gen/_river_short
execute if score #riv_dir dr_var matches 2 positioned ~ ~ ~-1 as @n[type=marker,tag=dr_riv_line,distance=..0.4] run return run function derailed:dev/gen/_river_short
execute positioned ~1 ~ ~ as @n[type=marker,tag=dr_riv_line,distance=..0.4] run function derailed:dev/gen/_river_short
