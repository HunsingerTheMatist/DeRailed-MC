# Narrows the region id to 141..145

execute if score #idmap_id dr_var matches 141..143 run function derailed:dev/idmap/branch/_nbbbbaa
execute if score #idmap_id dr_var matches 144..145 run function derailed:dev/idmap/branch/_nbbbbab
