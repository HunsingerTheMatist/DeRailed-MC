# Narrows the region id to 57..74

execute if score #idmap_id dr_var matches 57..65 run function derailed:dev/idmap/branch/_nabba
execute if score #idmap_id dr_var matches 66..74 run function derailed:dev/idmap/branch/_nabbb
