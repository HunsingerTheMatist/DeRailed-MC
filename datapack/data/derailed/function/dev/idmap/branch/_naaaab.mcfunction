# Narrows the region id to 5..9

execute if score #idmap_id dr_var matches 5..7 run function derailed:dev/idmap/branch/_naaaaba
execute if score #idmap_id dr_var matches 8..9 run function derailed:dev/idmap/branch/_naaaabb
