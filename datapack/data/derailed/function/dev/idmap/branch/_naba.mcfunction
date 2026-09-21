# Narrows the region id to 38..56

execute if score #idmap_id dr_var matches 38..47 run function derailed:dev/idmap/branch/_nabaa
execute if score #idmap_id dr_var matches 48..56 run function derailed:dev/idmap/branch/_nabab
