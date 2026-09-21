# Narrows the region id to 141..142

execute if score #idmap_id dr_var matches 141..141 run function derailed:dev/idmap/branch/_nbbbbaaaa
execute if score #idmap_id dr_var matches 142..142 run function derailed:dev/idmap/branch/_nbbbbaaab
