# Narrows the region id to 66..68

execute if score #idmap_id dr_var matches 66..67 run function derailed:dev/idmap/branch/_nabbbaaa
execute if score #idmap_id dr_var matches 68..68 run function derailed:dev/idmap/branch/_nabbbaab
