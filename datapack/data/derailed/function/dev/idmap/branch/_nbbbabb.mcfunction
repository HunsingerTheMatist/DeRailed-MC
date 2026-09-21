# Narrows the region id to 139..140

execute if score #idmap_id dr_var matches 139..139 run function derailed:dev/idmap/branch/_nbbbabba
execute if score #idmap_id dr_var matches 140..140 run function derailed:dev/idmap/branch/_nbbbabbb
