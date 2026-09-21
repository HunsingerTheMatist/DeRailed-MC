# Narrows the region id to 90..93

execute if score #idmap_id dr_var matches 90..91 run function derailed:dev/idmap/branch/_nbaabba
execute if score #idmap_id dr_var matches 92..93 run function derailed:dev/idmap/branch/_nbaabbb
