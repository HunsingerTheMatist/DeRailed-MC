# Narrows the region id to 109..112

execute if score #idmap_id dr_var matches 109..110 run function derailed:dev/idmap/branch/_nbabbba
execute if score #idmap_id dr_var matches 111..112 run function derailed:dev/idmap/branch/_nbabbbb
