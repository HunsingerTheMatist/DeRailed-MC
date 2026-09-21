# Narrows the region id to 109..110

execute if score #idmap_id dr_var matches 109..109 run function derailed:dev/idmap/branch/_nbabbbaa
execute if score #idmap_id dr_var matches 110..110 run function derailed:dev/idmap/branch/_nbabbbab
