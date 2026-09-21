# Narrows the region id to 0..149

execute if score #idmap_id dr_var matches 0..74 run function derailed:dev/idmap/branch/_na
execute if score #idmap_id dr_var matches 75..149 run function derailed:dev/idmap/branch/_nb
