# Narrows the region id to 144..145

execute if score #idmap_id dr_var matches 144..144 run function derailed:dev/idmap/branch/_nbbbbaba
execute if score #idmap_id dr_var matches 145..145 run function derailed:dev/idmap/branch/_nbbbbabb
