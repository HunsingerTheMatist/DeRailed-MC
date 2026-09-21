# Narrows the region id to 0..4

execute if score #idmap_id dr_var matches 0..2 run function derailed:dev/idmap/branch/_naaaaaa
execute if score #idmap_id dr_var matches 3..4 run function derailed:dev/idmap/branch/_naaaaab
