# Narrows the region id to 90..91

execute if score #idmap_id dr_var matches 90..90 run function derailed:dev/idmap/branch/_nbaabbaa
execute if score #idmap_id dr_var matches 91..91 run function derailed:dev/idmap/branch/_nbaabbab
