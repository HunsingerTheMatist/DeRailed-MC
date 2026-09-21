# Narrows the region id to 141..149

execute if score #idmap_id dr_var matches 141..145 run function derailed:dev/idmap/branch/_nbbbba
execute if score #idmap_id dr_var matches 146..149 run function derailed:dev/idmap/branch/_nbbbbb
