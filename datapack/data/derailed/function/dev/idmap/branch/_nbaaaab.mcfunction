# Narrows the region id to 78..79

execute if score #idmap_id dr_var matches 78..78 run function derailed:dev/idmap/branch/_nbaaaaba
execute if score #idmap_id dr_var matches 79..79 run function derailed:dev/idmap/branch/_nbaaaabb
