# Narrows the region id to 55..56

execute if score #idmap_id dr_var matches 55..55 run function derailed:dev/idmap/branch/_nababbba
execute if score #idmap_id dr_var matches 56..56 run function derailed:dev/idmap/branch/_nababbbb
