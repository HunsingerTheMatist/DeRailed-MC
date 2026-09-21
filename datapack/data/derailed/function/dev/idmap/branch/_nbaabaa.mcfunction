# Narrows the region id to 85..87

execute if score #idmap_id dr_var matches 85..86 run function derailed:dev/idmap/branch/_nbaabaaa
execute if score #idmap_id dr_var matches 87..87 run function derailed:dev/idmap/branch/_nbaabaab
