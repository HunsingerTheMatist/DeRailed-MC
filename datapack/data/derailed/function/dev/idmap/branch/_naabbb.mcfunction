# Narrows the region id to 34..37

execute if score #idmap_id dr_var matches 34..35 run function derailed:dev/idmap/branch/_naabbba
execute if score #idmap_id dr_var matches 36..37 run function derailed:dev/idmap/branch/_naabbbb
