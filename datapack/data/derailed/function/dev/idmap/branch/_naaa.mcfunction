# Narrows the region id to 0..18

execute if score #idmap_id dr_var matches 0..9 run function derailed:dev/idmap/branch/_naaaa
execute if score #idmap_id dr_var matches 10..18 run function derailed:dev/idmap/branch/_naaab
