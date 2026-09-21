# Narrows the region id to 29..37

execute if score #idmap_id dr_var matches 29..33 run function derailed:dev/idmap/branch/_naabba
execute if score #idmap_id dr_var matches 34..37 run function derailed:dev/idmap/branch/_naabbb
