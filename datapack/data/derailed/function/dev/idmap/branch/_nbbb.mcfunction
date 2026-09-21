# Narrows the region id to 132..149

execute if score #idmap_id dr_var matches 132..140 run function derailed:dev/idmap/branch/_nbbba
execute if score #idmap_id dr_var matches 141..149 run function derailed:dev/idmap/branch/_nbbbb
