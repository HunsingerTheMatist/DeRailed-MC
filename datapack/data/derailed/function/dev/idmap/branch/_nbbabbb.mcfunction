# Narrows the region id to 130..131

execute if score #idmap_id dr_var matches 130..130 run function derailed:dev/idmap/branch/_nbbabbba
execute if score #idmap_id dr_var matches 131..131 run function derailed:dev/idmap/branch/_nbbabbbb
