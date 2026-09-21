# Narrows the region id to 80..81

execute if score #idmap_id dr_var matches 80..80 run function derailed:dev/idmap/branch/_nbaaabaaa
execute if score #idmap_id dr_var matches 81..81 run function derailed:dev/idmap/branch/_nbaaabaab
