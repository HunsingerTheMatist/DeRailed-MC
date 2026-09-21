# Narrows the region id to 92..93

execute if score #idmap_id dr_var matches 92..92 run function derailed:dev/idmap/branch/_nbaabbba
execute if score #idmap_id dr_var matches 93..93 run function derailed:dev/idmap/branch/_nbaabbbb
