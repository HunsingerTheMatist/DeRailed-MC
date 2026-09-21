# Narrows the region id to 71..74

execute if score #idmap_id dr_var matches 71..72 run function derailed:dev/idmap/branch/_nabbbba
execute if score #idmap_id dr_var matches 73..74 run function derailed:dev/idmap/branch/_nabbbbb
