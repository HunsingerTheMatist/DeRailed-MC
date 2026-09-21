# Narrows the region id to 3..4

execute if score #idmap_id dr_var matches 3..3 run function derailed:dev/idmap/branch/_naaaaaba
execute if score #idmap_id dr_var matches 4..4 run function derailed:dev/idmap/branch/_naaaaabb
