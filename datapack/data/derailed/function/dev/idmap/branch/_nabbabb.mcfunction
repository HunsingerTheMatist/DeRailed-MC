# Narrows the region id to 64..65

execute if score #idmap_id dr_var matches 64..64 run function derailed:dev/idmap/branch/_nabbabba
execute if score #idmap_id dr_var matches 65..65 run function derailed:dev/idmap/branch/_nabbabbb
