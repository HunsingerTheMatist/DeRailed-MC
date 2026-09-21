# Narrows the region id to 132..134

execute if score #idmap_id dr_var matches 132..133 run function derailed:dev/idmap/branch/_nbbbaaaa
execute if score #idmap_id dr_var matches 134..134 run function derailed:dev/idmap/branch/_nbbbaaab
