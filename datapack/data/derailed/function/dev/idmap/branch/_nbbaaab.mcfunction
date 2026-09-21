# Narrows the region id to 116..117

execute if score #idmap_id dr_var matches 116..116 run function derailed:dev/idmap/branch/_nbbaaaba
execute if score #idmap_id dr_var matches 117..117 run function derailed:dev/idmap/branch/_nbbaaabb
