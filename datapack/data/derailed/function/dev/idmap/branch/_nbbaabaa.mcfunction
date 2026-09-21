# Narrows the region id to 118..119

execute if score #idmap_id dr_var matches 118..118 run function derailed:dev/idmap/branch/_nbbaabaaa
execute if score #idmap_id dr_var matches 119..119 run function derailed:dev/idmap/branch/_nbbaabaab
