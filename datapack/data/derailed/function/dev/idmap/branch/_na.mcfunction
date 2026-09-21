# Narrows the region id to 0..74

execute if score #idmap_id dr_var matches 0..37 run function derailed:dev/idmap/branch/_naa
execute if score #idmap_id dr_var matches 38..74 run function derailed:dev/idmap/branch/_nab
