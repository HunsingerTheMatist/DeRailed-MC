# Narrows the region id to 94..112

execute if score #idmap_id dr_var matches 94..103 run function derailed:dev/idmap/branch/_nbaba
execute if score #idmap_id dr_var matches 104..112 run function derailed:dev/idmap/branch/_nbabb
