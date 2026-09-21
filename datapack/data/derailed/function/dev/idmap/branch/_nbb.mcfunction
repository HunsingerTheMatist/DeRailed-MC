# Narrows the region id to 113..149

execute if score #idmap_id dr_var matches 113..131 run function derailed:dev/idmap/branch/_nbba
execute if score #idmap_id dr_var matches 132..149 run function derailed:dev/idmap/branch/_nbbb
