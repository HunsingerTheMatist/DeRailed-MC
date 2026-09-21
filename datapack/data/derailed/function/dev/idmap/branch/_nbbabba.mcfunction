# Narrows the region id to 128..129

execute if score #idmap_id dr_var matches 128..128 run function derailed:dev/idmap/branch/_nbbabbaa
execute if score #idmap_id dr_var matches 129..129 run function derailed:dev/idmap/branch/_nbbabbab
