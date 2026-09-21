# Narrows the region id to 104..105

execute if score #idmap_id dr_var matches 104..104 run function derailed:dev/idmap/branch/_nbabbaaaa
execute if score #idmap_id dr_var matches 105..105 run function derailed:dev/idmap/branch/_nbabbaaab
