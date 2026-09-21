# Narrows the region id to 15..18

execute if score #idmap_id dr_var matches 15..16 run function derailed:dev/idmap/branch/_naaabba
execute if score #idmap_id dr_var matches 17..18 run function derailed:dev/idmap/branch/_naaabbb
