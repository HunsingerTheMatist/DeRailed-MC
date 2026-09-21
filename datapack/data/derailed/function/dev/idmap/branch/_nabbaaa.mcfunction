# Narrows the region id to 57..59

execute if score #idmap_id dr_var matches 57..58 run function derailed:dev/idmap/branch/_nabbaaaa
execute if score #idmap_id dr_var matches 59..59 run function derailed:dev/idmap/branch/_nabbaaab
