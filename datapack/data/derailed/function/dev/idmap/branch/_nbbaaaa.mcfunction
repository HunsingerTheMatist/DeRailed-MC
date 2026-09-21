# Narrows the region id to 113..115

execute if score #idmap_id dr_var matches 113..114 run function derailed:dev/idmap/branch/_nbbaaaaa
execute if score #idmap_id dr_var matches 115..115 run function derailed:dev/idmap/branch/_nbbaaaab
