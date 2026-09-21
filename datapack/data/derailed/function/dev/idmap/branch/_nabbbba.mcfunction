# Narrows the region id to 71..72

execute if score #idmap_id dr_var matches 71..71 run function derailed:dev/idmap/branch/_nabbbbaa
execute if score #idmap_id dr_var matches 72..72 run function derailed:dev/idmap/branch/_nabbbbab
