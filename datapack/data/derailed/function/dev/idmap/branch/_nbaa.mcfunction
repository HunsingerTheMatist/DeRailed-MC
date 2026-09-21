# Narrows the region id to 75..93

execute if score #idmap_id dr_var matches 75..84 run function derailed:dev/idmap/branch/_nbaaa
execute if score #idmap_id dr_var matches 85..93 run function derailed:dev/idmap/branch/_nbaab
