# Narrows the region id to 66..74

execute if score #idmap_id dr_var matches 66..70 run function derailed:dev/idmap/branch/_nabbba
execute if score #idmap_id dr_var matches 71..74 run function derailed:dev/idmap/branch/_nabbbb
