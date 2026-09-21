# Narrows the region id to 132..136

execute if score #idmap_id dr_var matches 132..134 run function derailed:dev/idmap/branch/_nbbbaaa
execute if score #idmap_id dr_var matches 135..136 run function derailed:dev/idmap/branch/_nbbbaab
