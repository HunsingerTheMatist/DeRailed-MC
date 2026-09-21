# Narrows the region id to 41..42

execute if score #idmap_id dr_var matches 41..41 run function derailed:dev/idmap/branch/_nabaaaba
execute if score #idmap_id dr_var matches 42..42 run function derailed:dev/idmap/branch/_nabaaabb
