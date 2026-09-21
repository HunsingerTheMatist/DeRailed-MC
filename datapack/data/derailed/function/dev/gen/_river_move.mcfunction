
# Carries the head whichever way '#riv_dir' now points

execute if score #riv_dir dr_var matches 0 run return run function derailed:dev/gen/_river_go_s
execute if score #riv_dir dr_var matches 1 run return run function derailed:dev/gen/_river_go_w
execute if score #riv_dir dr_var matches 2 run return run function derailed:dev/gen/_river_go_n
execute if score #riv_dir dr_var matches 3 run return run function derailed:dev/gen/_river_go_e
