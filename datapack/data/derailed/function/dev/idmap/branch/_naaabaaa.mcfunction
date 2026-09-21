# Narrows the region id to 10..11

execute if score #idmap_id dr_var matches 10..10 run function derailed:dev/idmap/branch/_naaabaaaa
execute if score #idmap_id dr_var matches 11..11 run function derailed:dev/idmap/branch/_naaabaaab
