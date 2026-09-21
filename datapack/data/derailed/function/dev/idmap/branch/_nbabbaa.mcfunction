# Narrows the region id to 104..106

execute if score #idmap_id dr_var matches 104..105 run function derailed:dev/idmap/branch/_nbabbaaa
execute if score #idmap_id dr_var matches 106..106 run function derailed:dev/idmap/branch/_nbabbaab
