# Narrows the region id to 46..47

execute if score #idmap_id dr_var matches 46..46 run function derailed:dev/idmap/branch/_nabaabba
execute if score #idmap_id dr_var matches 47..47 run function derailed:dev/idmap/branch/_nabaabbb
