# Narrows the region id to 10..12

execute if score #idmap_id dr_var matches 10..11 run function derailed:dev/idmap/branch/_naaabaaa
execute if score #idmap_id dr_var matches 12..12 run function derailed:dev/idmap/branch/_naaabaab
