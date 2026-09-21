# Narrows the region id to 132..140

execute if score #idmap_id dr_var matches 132..136 run function derailed:dev/idmap/branch/_nbbbaa
execute if score #idmap_id dr_var matches 137..140 run function derailed:dev/idmap/branch/_nbbbab
