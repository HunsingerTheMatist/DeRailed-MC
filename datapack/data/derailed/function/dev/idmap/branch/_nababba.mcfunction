# Narrows the region id to 53..54

execute if score #idmap_id dr_var matches 53..53 run function derailed:dev/idmap/branch/_nababbaa
execute if score #idmap_id dr_var matches 54..54 run function derailed:dev/idmap/branch/_nababbab
