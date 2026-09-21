# Narrows the region id to 75..79

execute if score #idmap_id dr_var matches 75..77 run function derailed:dev/idmap/branch/_nbaaaaa
execute if score #idmap_id dr_var matches 78..79 run function derailed:dev/idmap/branch/_nbaaaab
