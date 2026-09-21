# Narrows the region id to 0..1

execute if score #idmap_id dr_var matches 0..0 run function derailed:dev/idmap/branch/_naaaaaaaa
execute if score #idmap_id dr_var matches 1..1 run function derailed:dev/idmap/branch/_naaaaaaab
