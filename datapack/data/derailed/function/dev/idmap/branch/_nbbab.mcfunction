# Narrows the region id to 123..131

execute if score #idmap_id dr_var matches 123..127 run function derailed:dev/idmap/branch/_nbbaba
execute if score #idmap_id dr_var matches 128..131 run function derailed:dev/idmap/branch/_nbbabb
