# Narrows the region id to 113..117

execute if score #idmap_id dr_var matches 113..115 run function derailed:dev/idmap/branch/_nbbaaaa
execute if score #idmap_id dr_var matches 116..117 run function derailed:dev/idmap/branch/_nbbaaab
