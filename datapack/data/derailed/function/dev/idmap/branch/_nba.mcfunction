# Narrows the region id to 75..112

execute if score #idmap_id dr_var matches 75..93 run function derailed:dev/idmap/branch/_nbaa
execute if score #idmap_id dr_var matches 94..112 run function derailed:dev/idmap/branch/_nbab
