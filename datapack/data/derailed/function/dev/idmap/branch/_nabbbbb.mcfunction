# Narrows the region id to 73..74

execute if score #idmap_id dr_var matches 73..73 run function derailed:dev/idmap/branch/_nabbbbba
execute if score #idmap_id dr_var matches 74..74 run function derailed:dev/idmap/branch/_nabbbbbb
