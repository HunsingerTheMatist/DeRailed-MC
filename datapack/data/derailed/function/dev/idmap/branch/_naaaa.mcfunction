# Narrows the region id to 0..9

execute if score #idmap_id dr_var matches 0..4 run function derailed:dev/idmap/branch/_naaaaa
execute if score #idmap_id dr_var matches 5..9 run function derailed:dev/idmap/branch/_naaaab
