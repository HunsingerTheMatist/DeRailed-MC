# Narrows the region id to 132..133

execute if score #idmap_id dr_var matches 132..132 run function derailed:dev/idmap/branch/_nbbbaaaaa
execute if score #idmap_id dr_var matches 133..133 run function derailed:dev/idmap/branch/_nbbbaaaab
