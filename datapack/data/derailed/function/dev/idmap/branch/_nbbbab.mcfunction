# Narrows the region id to 137..140

execute if score #idmap_id dr_var matches 137..138 run function derailed:dev/idmap/branch/_nbbbaba
execute if score #idmap_id dr_var matches 139..140 run function derailed:dev/idmap/branch/_nbbbabb
