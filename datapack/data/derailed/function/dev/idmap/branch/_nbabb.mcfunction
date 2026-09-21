# Narrows the region id to 104..112

execute if score #idmap_id dr_var matches 104..108 run function derailed:dev/idmap/branch/_nbabba
execute if score #idmap_id dr_var matches 109..112 run function derailed:dev/idmap/branch/_nbabbb
