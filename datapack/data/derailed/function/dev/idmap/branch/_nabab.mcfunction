# Narrows the region id to 48..56

execute if score #idmap_id dr_var matches 48..52 run function derailed:dev/idmap/branch/_nababa
execute if score #idmap_id dr_var matches 53..56 run function derailed:dev/idmap/branch/_nababb
