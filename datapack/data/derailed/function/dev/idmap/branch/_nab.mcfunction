# Narrows the region id to 38..74

execute if score #idmap_id dr_var matches 38..56 run function derailed:dev/idmap/branch/_naba
execute if score #idmap_id dr_var matches 57..74 run function derailed:dev/idmap/branch/_nabb
