# Narrows the region id to 38..42

execute if score #idmap_id dr_var matches 38..40 run function derailed:dev/idmap/branch/_nabaaaa
execute if score #idmap_id dr_var matches 41..42 run function derailed:dev/idmap/branch/_nabaaab
