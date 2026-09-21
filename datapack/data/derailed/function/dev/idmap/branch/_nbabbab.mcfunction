# Narrows the region id to 107..108

execute if score #idmap_id dr_var matches 107..107 run function derailed:dev/idmap/branch/_nbabbaba
execute if score #idmap_id dr_var matches 108..108 run function derailed:dev/idmap/branch/_nbabbabb
