# Narrows the region id to 102..103

execute if score #idmap_id dr_var matches 102..102 run function derailed:dev/idmap/branch/_nbababba
execute if score #idmap_id dr_var matches 103..103 run function derailed:dev/idmap/branch/_nbababbb
