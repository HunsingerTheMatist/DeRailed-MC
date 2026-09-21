# Narrows the region id to 0..2

execute if score #idmap_id dr_var matches 0..1 run function derailed:dev/idmap/branch/_naaaaaaa
execute if score #idmap_id dr_var matches 2..2 run function derailed:dev/idmap/branch/_naaaaaab
