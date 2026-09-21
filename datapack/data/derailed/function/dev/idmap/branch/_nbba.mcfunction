# Narrows the region id to 113..131

execute if score #idmap_id dr_var matches 113..122 run function derailed:dev/idmap/branch/_nbbaa
execute if score #idmap_id dr_var matches 123..131 run function derailed:dev/idmap/branch/_nbbab
