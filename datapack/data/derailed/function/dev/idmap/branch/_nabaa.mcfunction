# Narrows the region id to 38..47

execute if score #idmap_id dr_var matches 38..42 run function derailed:dev/idmap/branch/_nabaaa
execute if score #idmap_id dr_var matches 43..47 run function derailed:dev/idmap/branch/_nabaab
