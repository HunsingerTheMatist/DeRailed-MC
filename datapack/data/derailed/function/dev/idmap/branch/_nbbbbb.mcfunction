# Narrows the region id to 146..149

execute if score #idmap_id dr_var matches 146..147 run function derailed:dev/idmap/branch/_nbbbbba
execute if score #idmap_id dr_var matches 148..149 run function derailed:dev/idmap/branch/_nbbbbbb
