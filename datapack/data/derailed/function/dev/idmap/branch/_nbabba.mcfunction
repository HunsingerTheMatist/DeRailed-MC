# Narrows the region id to 104..108

execute if score #idmap_id dr_var matches 104..106 run function derailed:dev/idmap/branch/_nbabbaa
execute if score #idmap_id dr_var matches 107..108 run function derailed:dev/idmap/branch/_nbabbab
