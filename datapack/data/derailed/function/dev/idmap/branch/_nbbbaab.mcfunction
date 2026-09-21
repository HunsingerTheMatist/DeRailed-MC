# Narrows the region id to 135..136

execute if score #idmap_id dr_var matches 135..135 run function derailed:dev/idmap/branch/_nbbbaaba
execute if score #idmap_id dr_var matches 136..136 run function derailed:dev/idmap/branch/_nbbbaabb
